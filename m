Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8532DB507
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgLOUZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgLOUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:24:50 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CDC06138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:16:43 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id q75so425958wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zOqoxSagYmofoKUHmkIlwhwGeUtRKR7Bpdk69rbfx8=;
        b=WV7un/KeKac/x+b7RhIrEqMBzOIu2cYPGIJacSyM0+VTxarTDZe6Cm9mb1yLu+bvZv
         Ip8PiNON1qRh0s1LBS02OaoopAmHfATc9AxbI+TW+jXLyJT1QFLuQuPGo1W6Zp8a0Wdj
         s85BtfQYPo4jOn9o2zX5Mokznz79NrlgeShIpBYiecG3iQCqxLghRjK/XrWA5EvjZTWY
         2TeXFPbmi/d1w85gahvbBJdHwNg/ZwThjrIFw/BCNOiAR3Q/CYccXGTsOHsf49cKxlL4
         CQ5uA9cwmInAqrh7BAIlS1mpfCRFmgsrKe/n/hS4Bzg4ne4iJSNQ6+wWqt6jTj7II+a+
         tLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zOqoxSagYmofoKUHmkIlwhwGeUtRKR7Bpdk69rbfx8=;
        b=oj3ASyJrJETyp/wSBsGl8ZpH6Df892v+0Q+G3hhtAuC8Yf4tEJVTNcrpNrxz5b8YL8
         TOAvpOS8Gg1ULutupXjUBvsbXIIqgGPbMmwfNsMmTPiHvG1795VAckVsn8tyFnnwGW+5
         CnYxsgZzggNhLoMpZvMtwIvDl8y7WQQBGEQE52dlnKLauFBUHibOPHnqrX0p9DcogH3V
         oK0w06lVNjx/lz0nsIJx3cS2BGaHIM31Ur/y1JkpZvnzj6Y4FU/8ZZBDo8veD+ULrugw
         b4SLEuk2NPeJ63lvVLUbVVGbsNqJ2jsCogDcpNK8qXJeaqNSxhUJ8wMojlIUG1qwE1SA
         BbsA==
X-Gm-Message-State: AOAM531oCe9iUAtOTpswgaaVrVTa3kPdsyrNCGjrZUow91+P61MkByRT
        WtiMxDPkJzx0XXhdt9mJWmE=
X-Google-Smtp-Source: ABdhPJyp07CyyeGRkvwcBp1uzTblfK5nAB1mSINYdhmLZ6m2Dmx+BMzg3T7jGG6q2Idc1CtECWiUiQ==
X-Received: by 2002:a1c:b082:: with SMTP id z124mr492939wme.129.1608063401802;
        Tue, 15 Dec 2020 12:16:41 -0800 (PST)
Received: from debian (host-92-5-250-55.as43234.net. [92.5.250.55])
        by smtp.gmail.com with ESMTPSA id t10sm38630929wrp.39.2020.12.15.12.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Dec 2020 12:16:41 -0800 (PST)
Date:   Tue, 15 Dec 2020 20:16:39 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Milan Lakhani <milan.lakhani@codethink.co.uk>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Documentation: process: Correct numbering
Message-ID: <20201215201639.cuq7xtyanbk6bxan@debian>
References: <1608061835-5118-1-git-send-email-milan.lakhani@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608061835-5118-1-git-send-email-milan.lakhani@codethink.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milan,

On Tue, Dec 15, 2020 at 07:50:35PM +0000, Milan Lakhani wrote:
> Renumber the steps in submit-checklist.rst as some numbers were skipped.
> 
> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>

Maybe you can also add:
Fixes: 72deb455b5ec ("block: remove CONFIG_LBDAF")

But I am confused about why you have added Greg and staging list instead
of 'linux-doc@vger.kernel.org'.

--
Regards
Sudip
