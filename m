Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE952CE723
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgLDEvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgLDEvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:51:52 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4954C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 20:51:12 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id l200so4840037oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 20:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNuE5GFHoDJ2lKhdztnB9ycEKhCes0TVFJagK8diM14=;
        b=lDndcSOtHAV3kBy3uG6eeqdAiGPxdfj64vknrgN3TtuWM3oE2pmwMFCdIZvKkv5Se2
         M0P4Gp5dWCEByP54ebPqQFdAKRRkpRELnH3bQrZB2kfsBn5RSDoNhUfXVSlxnOpZNMmX
         wxWwOFJe3sXc3lefWwbNC5qLrcFLrZWMUCMkcNHPt3q2fVthBtrC9ZKMOkWVnZqdx0Wc
         fXn1bmNqmq8ngGNue2GgsldWwIJ/PbE36bGzKyq6S1qtBUuz0qg4O9qBsTzRc43flOVn
         Een4ceTb7MfEz3zYmYKF3aFmHs78MY4PMuwutwJZ/YBPtlYQuqT5hU2HyRCnSoMhCPjv
         lJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNuE5GFHoDJ2lKhdztnB9ycEKhCes0TVFJagK8diM14=;
        b=uC/KbrrA0pM+4hY/G4Ne4GjsSNfVCuDnvjYsoboJHOpMvNpvym9ZR/2Abg/EFDwApA
         ntru0B5Ot95nPayY7ApSBDABFNy9OyS6iaYPNXnhhK0t2zAaygaPK5pSsMqcGcWdAuIx
         Umm2od6ol/FHpwrjJ7p2Zhunm3Ogt/ERpo1DQcVCz/R4ZG5A8UuCfhI+RkGQtWEInWGd
         k7tPl5q2zIdTvksJmgrr8WOJWWIf35JKnr/kZJm9pArZ5jrRXHWnwDz7s9CaqjbKfOXS
         IiQtxGsuKNsAyM4Du3xlkYIoNh8/wFnZl7uNdgmnAiOY6pVFm5N+Sz/FJ5sKSf6l0PQZ
         w6rw==
X-Gm-Message-State: AOAM533snUl0wo2Qby9dVeCFxXBGzNYaJsTdsVxsDJrMziJgjChcrAGY
        dYUXOQojoWpMr3315Miw1OM=
X-Google-Smtp-Source: ABdhPJxxdSPPj0YfQLcfpBWwOgOaIwKcJYh5K0ALCh+dlw8UrGVaUcfroAniGJGZrrSufnmMqOWd8w==
X-Received: by 2002:aca:3589:: with SMTP id c131mr1910712oia.57.1607057472203;
        Thu, 03 Dec 2020 20:51:12 -0800 (PST)
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net. [172.10.235.113])
        by smtp.gmail.com with ESMTPSA id e8sm391823oti.76.2020.12.03.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 20:51:11 -0800 (PST)
Date:   Thu, 3 Dec 2020 20:51:09 -0800
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X8nAParf9GW9LaGV@sol.localdomain>
References: <20201204005847.654074-1-daeho43@gmail.com>
 <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain>
 <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 01:48:24PM +0900, Daeho Jeong wrote:
> Eric,
> 
> I have another question.
> I understand enabling the verity can be possible in the middle of I/O.
> Is the opposite way also possible? Actually, I couldn't find any
> disabling function of it, though.
> 

No, disabling fs-verity on a file isn't possible.

- Eric
