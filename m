Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9981B7F23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgDXTlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgDXTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:41:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03652C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:41:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u15so11210370ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEmEzSJAW12x5niGKKzPXSqsRmQBFq2lP6H8xvuac/8=;
        b=T0keOgZ72bgaeEiqotFnnG+NMkzgKYHGXH4TyFbkmZQOJe1Y5iKcFbRjOuVS3LytBL
         W6AnOWDW2QWZo3w+XoSlX7QKg7WFduDC+turDLabtmC3eHu2R+LW2LppYuJYXdj40rg7
         CdC1QLOEEL0R1Cimqms8CMRslN8tW7OXjqcp181VPdrvY8W8QYwXkvlGnezntNU/aIQI
         i6YsVJ+qBo1IpmfuneESoyprPvhhXr26CeMvNdDtUxyovd7PslG1FH6YR8sVB7ohtRad
         QOWlk/axNwWA9QPd0lqbh3Eau8RDrkadohiHGyCxCHAzXRPCkwjqYlFo45dJvWYiXb2y
         7ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEmEzSJAW12x5niGKKzPXSqsRmQBFq2lP6H8xvuac/8=;
        b=K7AVGQowQJ6/H5nlw5L42Gq5ydaJoIZYYo6FeEPMdc7BrFzTHUN7uKbM2a3aQ1vcga
         TTE5/a6dR425SPEFMQjuaRcgBtCrCW0c1hhzc5VWOdh+dao+vLm8cW+HY2+TER204lrN
         B0bUa+N6H6V0iYvJnV9y/Ql4RxCdjnZe8SZt9A9d8azFRWDgsSqVq+0lN0torGBPv9RD
         YqBeIYe3UHlcmsuheetdS5WyyBVm4GRsme8W1D88CMeTjLmYqBZrd6eDqk/0juxQb2vq
         ep2h2+v6KuCp+qUAPrawVqFtNHEcnVil+GilDt1EQQAV5SJa4aQa27F3Deogvgm/MOpB
         8J2A==
X-Gm-Message-State: AGi0PuYLDf3X6rS4mxM9HQPbxM+octDPUSbZCetoG2qiMOhHDCMr7qo7
        Oy5ER8UC3keWf5P8aZDNoUPLak3OMYuSUC2F4uN47Q==
X-Google-Smtp-Source: APiQypI4Xi6+DbAAYIeOQPzrEcE/mxStfNg2RlTAQ/87ko7Y+RTOVwvrDrzFbofvytmtXUu0lTzmeVzRLH+KYXFDMfY=
X-Received: by 2002:a2e:9791:: with SMTP id y17mr7027497lji.174.1587757306172;
 Fri, 24 Apr 2020 12:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200328185916.98423-1-rajatja@google.com> <20200328185916.98423-3-rajatja@google.com>
 <20200410164140.GA25924@bogus>
In-Reply-To: <20200410164140.GA25924@bogus>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 24 Apr 2020 12:41:09 -0700
Message-ID: <CACK8Z6G=oy9Gesazk1jJVhk22Dgm8_TGZCcpNndkv+WLqAe8hg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: input/atkbd.txt: Add binding for "function-row-physmap"
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@google.com>,
        Zentaro Kavanagh <zentaro@google.com>,
        Dominik Behr <dbehr@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 10, 2020 at 10:38 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Mar 28, 2020 at 11:59:14AM -0700, Rajat Jain wrote:
> > Create the documentation for the new introduced property, that
> > describes the function-row keys physical positions.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: Same as v3
> > v3: same as v2
> > v2: Remove the Change-Id from the commit log
> >
> >  .../devicetree/bindings/input/atkbd.txt       | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/atkbd.txt
> >
> > diff --git a/Documentation/devicetree/bindings/input/atkbd.txt b/Documentation/devicetree/bindings/input/atkbd.txt
> > new file mode 100644
> > index 0000000000000..816653eb8e98d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/atkbd.txt
> > @@ -0,0 +1,34 @@
> > +Device tree bindings for AT / PS2 keyboard device
> > +
> > +Optional properties:
> > +
> > +     function-row-physmap:
> > +                     An ordered array of the physical codes for the function
> > +                     row keys. Arranged in order from left to right.
>
> A single optional property doesn't constitute a DT binding.
>
> > +
> > +Example:
> > +
> > +     This is a sample ACPI _DSD node describing the property:
>
> Neither does this ACPI stuff.

I assume this means a nack to the documentation patches.

Dmitry, can you apply the other patches in the series?

Thanks,

Rajat

>
> Rob
