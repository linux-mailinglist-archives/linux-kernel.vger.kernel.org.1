Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17122A59F9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgKCWUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbgKCWUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:20:17 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 14:20:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id e27so1545788lfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 14:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGOEhKsA2OwG13b5gtkFmoIkhKN0Tzb9Yz1d9AT63nE=;
        b=K1bjUKfX51b5qotZAiYNouvyUDtkH7cr0GZdA9qNvLxnxk0L95HdWtEl4yID/8o5ew
         T3cOoBhbIgYJiILZSN1Gkm6ujI/dJvD646mMVFkHQTe+FXEtf56MJl63OFZVE0HgAo+C
         THbItY64tC1LOig9tvos2ldGnH5k9hJgJyjTDn6okS2HvL5MnpeLV212jQcBuFLWpA7E
         vOBc9Ip7M5kKzR3yMVQ/AIGzLN0OYO96I5bqwTMcX3Rrt64kA2xf3/s70Hl8EPeZX4RW
         qKDjdLro3yz/JG3KXODfBo9EqPCkpwkWwZ1eAMjCDcrpY+J5h1ESvJjKNPMqEub0pwr8
         Ho9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGOEhKsA2OwG13b5gtkFmoIkhKN0Tzb9Yz1d9AT63nE=;
        b=M1X4UOSX9HjsWt6K+gaB4Bxm2WKsP0cny81UzqIMaGS25c4GwA7gOyyMGvIEPiX3ce
         d2Ipw81PketXOfP5kIAFECY9+PRO7kV0h4g0k72tnJB2akc9J2NxhjwHgsybsc67/uqx
         djd0EKrUAtKQZnFyrgtB8+3/cqM633ZmrlafULe9W/WwwmvQKpwb8rDH20kZhf0ThMSz
         PeQeQhNz5suWcmsSUXtbmtfRZItJRlwdKpOsPTbmx5qd7ATNNGvzVJyi5hX/Ep9KylQD
         dnqz2Lk7cdXsH8WEXiFAf/nh2ONvtTtZzK3iO4MRXOrUPbsqxwLk6xfvBCyOOxiRJ0Ha
         tk9g==
X-Gm-Message-State: AOAM532cMP5D9T7SP4aZI27k9nI2htGuEoLJ8+CyMVDfO7qOhIIGgOci
        AJOtTXEXSa3gDlhIjnKboUNOHg==
X-Google-Smtp-Source: ABdhPJxRFm8qsXfpAv3oTL3woMRlKjMmcXF45qhzM91T8QG4fQEQSZWh7OW4c9/IsFKaaVMgS6bfEg==
X-Received: by 2002:ac2:59d1:: with SMTP id x17mr8553159lfn.142.1604442015603;
        Tue, 03 Nov 2020 14:20:15 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q5sm3728627lfe.262.2020.11.03.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 14:20:15 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E18A7101FC2; Wed,  4 Nov 2020 01:20:13 +0300 (+03)
Date:   Wed, 4 Nov 2020 01:20:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Airlie <airlied@gmail.com>, Lyude Paul <lyude@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
Message-ID: <20201103222013.hypmzlq7uuqufe76@box>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:33:08AM +1000, Dave Airlie wrote:
>       drm/nouveau/kms: Search for encoders' connectors properly

This commit (09838c4efe9a) broke boot for me. These two hunks in
particular:

@ -2066,7 +2120,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
                          outp->clr.mask, outp->set.mask);

                if (outp->clr.mask) {
-                       help->disable(encoder);
+                       help->atomic_disable(encoder, state);
                        interlock[NV50_DISP_INTERLOCK_CORE] |= 1;
                        if (outp->flush_disable) {
                                nv50_disp_atomic_commit_wndw(state, interlock);
@@ -2105,7 +2159,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
                          outp->set.mask, outp->clr.mask);

                if (outp->set.mask) {
-                       help->enable(encoder);
+                       help->atomic_enable(encoder, state);
                        interlock[NV50_DISP_INTERLOCK_CORE] = 1;
                }


I hacked up patch to use help->disable/help->enable if atomic_ versions
are NULL. It worked.

In my setup I stepped onto nv50_msto_help->atomic_enable == NULL. But
there are two more drm_encoder_helper_funcs in dispnv50/disp.c that don't
have atomic_enable/disable set: nv50_dac_help, nv50_pior_help.

-- 
 Kirill A. Shutemov
