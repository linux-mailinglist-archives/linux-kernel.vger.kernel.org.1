Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDF2CB105
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgLAXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLAXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:44:10 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBBEC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 15:43:30 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id s63so2221507pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fY5hyTL1LADJADDjDb5GgSei5a/r8R7nT6CdkOspJ28=;
        b=lba3JsSdXWmCmomk5hDRDrU0RfEXL/zI9mP+sysVQ26ffSeUkzoWmCnrwMD8MA3k0C
         MpoAbiOU7sfG9zEMNd1vBTW3GX8OLaoQb3QJGohAFbRlivgh3vW+/2Vxk+d8FJ1ZmHSj
         kxYoTW2Q0dCoOr7eF4D8S6zr12lEpAghudQ7KVgVZvpMnqb4yRJu1bts6mEnyvz72S0D
         bSnUGEut2DjNPXbqFowsWhJHt/yYpRyjt5TY9i39s48uRLZO+SJwG9YVSAy1gJLblrsV
         a/J9QoJJYBwKkF069EGYjV8yBW9IAhkgoksIu1oQ2kTE1nYZ2wLfQv5cWU1kDIAn2IqS
         /j5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fY5hyTL1LADJADDjDb5GgSei5a/r8R7nT6CdkOspJ28=;
        b=TH7bNJfOtgZj+MxuoBiyW7n+i6qSaSghM6Egdcg6soqzI4LTswUDQJY/4cv8yUndy+
         FUPVdroyh/pvpzQAxgPPHowrOtCk7aqdeiRBJoOix/HkqBJ6foA3UfSjGcYAl2H6DVkX
         OUAJO8VqIqrt6K96CJ5rkpgxDyBISMiMQWP6EDn3CkVlkbjos3FbFIGvknumYfX635r3
         neNZgtk99L1kfZqU9lcVcWZV+dHUbhPJPC/IBbf+n2hBWQcBThYUvPi2I5PyfV1zDg5W
         B7iLcUqGHP9pH74/rCag779LD9bhHOOsGXC6OQbezkMgUBRGIkNYxNW0YLNou+P7nJK+
         0cdw==
X-Gm-Message-State: AOAM5327w1eMr3cGSdQeL4MoO1Y9kNc+G6BZ67LMKaPuXSE3xEMyh6Wr
        IYKbhvV/k7PgbZSDX6VQFW9ucQ==
X-Google-Smtp-Source: ABdhPJwxw2fmhWBtHdIVtKdFchQm9O/5vYe7BHNrQ87GcJXUHXbUQqiahRlbXkb6titFrIE4fINVgA==
X-Received: by 2002:a63:4c12:: with SMTP id z18mr46620pga.66.1606866210006;
        Tue, 01 Dec 2020 15:43:30 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q35sm24158pjh.38.2020.12.01.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 15:43:29 -0800 (PST)
Date:   Tue, 1 Dec 2020 16:43:27 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: Re: [PATCH v3 01/15] dt-bindings: remoteproc: Add bindind to support
 autonomous processors
Message-ID: <20201201234327.GA1248055@xps15>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
 <20201126210642.897302-2-mathieu.poirier@linaro.org>
 <20201130173321.GB2662913@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130173321.GB2662913@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Nov 30, 2020 at 10:33:21AM -0700, Rob Herring wrote:
> On Thu, Nov 26, 2020 at 02:06:28PM -0700, Mathieu Poirier wrote:
> > This patch adds a binding to guide the remoteproc core on how to deal with
> > remote processors in two cases:
> > 
> > 1) When an application holding a reference to a remote processor character
> >    device interface crashes.
> > 
> > 2) when the platform driver for a remote processor is removed.
> > 
> > In both cases if "autonomous-on-core-reboot" is specified in the remote
> > processor DT node, the remoteproc core will detach the remote processor
> > rather than switching it off.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  .../bindings/remoteproc/remoteproc-core.yaml  | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
> > new file mode 100644
> > index 000000000000..3032734f42a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/remoteproc/remoteproc-core.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Binding for the remoteproc core applicable to all remote processors
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> > +
> > +description:
> > +  This document defines the binding recognised by the remoteproc core that can
> > +  be used by any remote processor in the subsystem.
> > +
> > +properties:
> > +  autonomous-on-core-reboot:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Used in two situations, i.e when a user space application releases the
> > +      handle it has on the remote processor's character driver interface and
> > +      when a remote processor's platform driver is being removed.  If defined,
> > +      this flag instructs the remoteproc core to detach the remote processor
> > +      rather than turning it off.
> 
> Userspace? character driver? platform driver? remoteproc core? Please 
> explain this without OS specific terms.

The remoteproc state machine is gaining in complexity and having technical terms
in the binding's description helps understand when and how it should be used.  I
could make it more generic but that will lead to confusion and abuse.  Should I
make it "rproc,autonomous-on-core-reboot" ?

> 
> Seems to me this would be implied by functionality the remote proc 
> provides.

Exactly - this binding is used by the remoteproc core itself.  It is specified
in the remote processor DT nodes but the individual platform drivers don't do
anything with it - the core takes care of enacting the desired behavior on their
behalf.  Otherwise each platform driver would end up adding the same code, which
nobody wants to see happening.

How do you want me to proceed?

Thanks,
Mathieu

> 
> Rob
