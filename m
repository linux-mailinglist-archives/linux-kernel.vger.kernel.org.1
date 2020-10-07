Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2799B286AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgJGWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgJGWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 18:07:24 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA76C061755;
        Wed,  7 Oct 2020 15:07:22 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id q26so3423934qtb.5;
        Wed, 07 Oct 2020 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v06OzhDCfO3v9dCSJzOWm4zspu5sFg87m9FD1VPHSeM=;
        b=J3gcxLgjpWbeCr2y1mMH1f4izWFZ16/CvxdZhl6D7WkRqrUXNHeDJvGyxadPc9wVPL
         3iIXU9UxYziV/ppj5i74jfNAPDFyPM/pUEJhWu9klBkPXaOsPfbhfumVkQOXZ4Bohm0l
         az5ILQGzIZ0DEdbJiYqmiAQANtJnlUoRIP2ouN6V2/b6PCuoAZajiEFBj2Tn1BhVmnrV
         sDEWBgkWA3/KBb9cr9/RoOoZ8HMY4Y6bfWau8RitQU8retnYGLaPAdvAW/0oZUqQRkhk
         4ESrLmT9Dhf9ugaE1Vc+NLx/9fXNZD++wKq3/fJ7N/9aYcplR+BgKLEspk7q+6Pth5oD
         w4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v06OzhDCfO3v9dCSJzOWm4zspu5sFg87m9FD1VPHSeM=;
        b=dWCty/veZY0/vgUPceDhE2oeitEFUVk6yvhWpcx4Cs7rqTVDWEYtTTO2eyDgO5/ufF
         g45HOs5MEhhBfoQnYDweXDmhSaweA5PyvCkmvUpIrHBcfVafaOasJOWFi6Wjpz85Nghs
         7AZn7mq3S/nL6b//m4XvUddpjGAXuP0KMBgOGH/7yRfH3SsuVdrE4dbFg9X5MW6YLPNU
         kQHzoVOFiZFcl+jMPTT51P1UilsPY28dKWcH73zgGwMl5BaA+lNhyIltNcXeNmPCAuR7
         Yv0EJcnuuBQCDuirpgCRncnBQ0COOe3f/9XpIx6WmkS/3Cqdj45OaXDdIAmUExJcPp+O
         QwtA==
X-Gm-Message-State: AOAM531RS8j22Zo96oCGAHyKc12KFR0Yh7/KHz55+SaqQfoDBblJfTyv
        h4hJK4IwhEmte9xQX2iLhuw=
X-Google-Smtp-Source: ABdhPJx9o9k2LVVgzkEV+bkz6gNWxaQbAObl0sh3yUEhA/a8tk0uRPA+5of72juc4bJZGKPtBaUIlQ==
X-Received: by 2002:ac8:2f79:: with SMTP id k54mr5641930qta.148.1602108441921;
        Wed, 07 Oct 2020 15:07:21 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id d47sm2657253qtk.53.2020.10.07.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 15:07:21 -0700 (PDT)
Date:   Wed, 7 Oct 2020 18:07:18 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and
 port 7
Message-ID: <20201007220718.GB1972@ubuntu>
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <cd64e0ccae3e5785c80ad4d73af533a40fc15876.1601655904.git.npcomplete13@gmail.com>
 <20201007210327.GE112961@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007210327.GE112961@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:03:27PM +0200, Andrew Lunn wrote:
> On Wed, Oct 07, 2020 at 03:01:51PM -0400, Vivek Unune wrote:
> > Add port 5 and port 7 which are connected to gmac0 & 1 respectively
> > DSA driver will use port 5 as cpu port and this works as well.
> 
> What port was used before this was added? The CPU port cannot be
> changed because it can break user space, the code which is configuring
> the master interface up.

Hi Andrew,

Port 8 was used before this. Factory firmware uses all three - 5, 7, 8 
I'm aware that current implementation of DSA driver does support
multiple CPU ports and uses the first one that is detected. DSA works
for either of the CPU ports.

In case of the non-DSA switch driver, which is enabled by default in
OpenWrt. Port 8 configuration will not work, since the non-DSA driver
uses first gmac core i.e. eth0. But since gmac0 isn't connected to
port 5, it doesn't work.

This router is currently not enabled in Openwrt and it doesn't
generate a firmware for public consumtion. So I'm sure this won't
affect anyone. Albeit, I've been generating custom firmware [1] for
this so I can get feedback on these changes I'm submitting.

With this patch series, I plan to enable firmware for this router
and free me up myself from building custom images. Moreover, the
router will start getting regular updates.

Thanks,

Vivek

[1] https://forum.openwrt.org/t/build-for-linksys-ea9500/1817
