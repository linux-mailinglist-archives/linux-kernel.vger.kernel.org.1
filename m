Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7827E2DEAD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgLRVMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgLRVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:12:05 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5CCC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 13:11:50 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id u203so3174081ybb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFsnWYgZv7EVrgBXFoXDcyOnuUF1YGc0qpDAPXty7qM=;
        b=E909suHsydiiXo6eDGwHUVoYI1cTbo8JAJZP8XMJD1W9CDP3Ett0Bg5T9kog8+0dpc
         f5ElkEHiSQ4oeKjj5l2xsyYlGw7O6beXkNQnMAMc2lvdq/EAcY8cVldzUexjVaxvzvWw
         AQz2Iu2E4meXkccmmjsXL19T+vA3sNsRrHt6MZScx46BULV0KHZlN7i5c0eMi2c3CkZ3
         lchsrvpcvnS9PU5PpfuWIhJceVMldtdPA0QGzCdbyqITHCfteAMDTo0IeuF+eR5xZ5d+
         UfiM2so+Q0xlYuFrXwPLLdgjnmy5ShkKwyz/oP+lOoWgVuME4XXHEaSQTZaQicia8X4U
         +qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFsnWYgZv7EVrgBXFoXDcyOnuUF1YGc0qpDAPXty7qM=;
        b=J2RhZhqfUuwPNuaumIImJKuIEI/nqD88ZiubXE4Os3ME69+32tQiyVeFBrxmnDIhjV
         s5FwyLpLu7saKLjON7Aphy0Rs5JrNZqplLFRFCAnfV45BK96HAEmrAeFHJB66XxTu1s4
         fbeFoEjlz3F99yD6iW856o8qQ1shrvy/ZxLoqPPDFe7eyfKlIBXdAyzFTTvI2aCnWvY3
         7RSg0ix0rHYGhONA9Wky5qd1LIlX18X/qanWKls4/gQCkU54rd0a7sgVZSI/iqv5WgY4
         vebo8imKmsUeBfZIjbm8kcfuYfZQ++AUfGdjdZEGECwLwW+CbeSEPQFW6qVx8Zw6srum
         ZTuw==
X-Gm-Message-State: AOAM530d23vCG1RN/Jta3H51YK1ZTz6fayOblmQ+uGXGdZsBpvN+gnzO
        C3Fe0QDi9VsPZWcOyPF7vHwGfdC2WCGW8fVeDt82n1vvL2op6+/z
X-Google-Smtp-Source: ABdhPJxo9vQhx5jAiwh3efAFGegWPXZc5sMvpOTSOYmtS93t0tF6VZI9BN3Hpbxzt0UpZAnOc12Vhp2kJlaPyIMW2tc=
X-Received: by 2002:a25:6604:: with SMTP id a4mr8745791ybc.412.1608325909702;
 Fri, 18 Dec 2020 13:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 18 Dec 2020 13:11:13 -0800
Message-ID: <CAGETcx9K8f8c+AT_AVtbgDn3=N9YtytoThj-KX_JQO9KfvTr1Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 7:17 PM Saravana Kannan <saravanak@google.com> wrote:
>
> As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
> be broken using logic was one of the last remaining reasons
> fw_devlink=on couldn't be set by default.
>
> This series changes fw_devlink so that when a cyclic dependency is found
> in firmware, the links between those devices fallback to permissive mode
> behavior. This way, the rest of the system still benefits from
> fw_devlink, but the ambiguous cases fallback to permissive mode.
>
> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> only for systems with device tree firmware):
> * Significantly cuts down deferred probes.
> * Device probe is effectively attempted in graph order.
> * Makes it much easier to load drivers as modules without having to
>   worry about functional dependencies between modules (depmod is still
>   needed for symbol dependencies).
>
> Greg/Rafael,
>
> Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
> see some issues due to device drivers that aren't following best
> practices (they don't expose the device to driver core). Want to
> identify those early on and try to have them fixed before 5.11 release.
> See [1] for an example of such a case.
>
> If we do end up have to revert anything, it'll just be Patch 5/5 (a one
> liner).
>
> Marc,
>
> You had hit issues with fw_devlink=on before on some of your systems.
> Want to give this a shot?

Marc,

If you decide to test this, please also pull in this patch. It should
fix all your interrupt issues.

https://lore.kernel.org/lkml/20201218210750.3455872-1-saravanak@google.com/

-Saravana
