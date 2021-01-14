Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902D72F5649
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbhANBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbhANBFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:05:11 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81EC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:04:30 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 30so2635484pgr.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qHqPRD8NyIOcIJgnLC82ewg0F2hDHmrpQ6SU6gEvVWw=;
        b=l4Y4+J5OhGdmGZxgAK04XbHpPRndLRxE3vBthhUnQYwoCedJPPUoESpNtAZtBX5F2E
         DA/fl2hVPSSFSZeAXamVPXGPUGAytibr4xL2qhWfvLRsqnSLkEWR1ukQdhdJrFnZ2bh9
         wnkEcTA9pbzcn+gEY1McHdjzJNPrEU63tJj5jo/cDVQONtf4oNCNWZFpZvsJEQFXzh2V
         IFXc2iuCl7ENuY4j+F0e1EeTr0c4r7kTCDb1x46soax8hul0PfEfFX6CP34IpbG9HAtw
         I7mR/SJnRpJYYgMw7e0JG80I4WGfmtSbnORJsgxBOvpDEJaL/poIsQa9/TPXuovazFvp
         PJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qHqPRD8NyIOcIJgnLC82ewg0F2hDHmrpQ6SU6gEvVWw=;
        b=MMcWXQgl3LaYhfV69o5q+z48Qu7PzivKuWGlYjaE5DAQkCLwWeXB+Vn3/UQD0BwCsv
         QPXOI/uUH6WNONDKUTckmGrwVn1rQx9J8gupQkmcQhkV0zCPgSvxONJp8v/o1N7nVIqA
         1ArR/jKThNBs+AP+wlHPemnmy/SwVFJpChloet/iNyggtuV0wQmK4aWjY2A8NLtb3fVT
         HtWmhdMVMRTT9fvq5JzxbxsHXv4ZXsPBI/F/SUqFh/K6G3wbSto95ozmWJNwMjsU7qgh
         ISObixdBEHNBDaVIzT1xPz/2TX2RZ3hEq7XM8Mil6xjXbJUV2ntl0mbcr0hYHgnThIEv
         JhuQ==
X-Gm-Message-State: AOAM531ZQQNo0447DVaaNtwiKGLhykfonrJ1VVgMLt75WZQFSa9/U1ed
        QB54YpWuorB+2fzeI+qIhNY=
X-Google-Smtp-Source: ABdhPJwu25mq6GMQcSBYlDZUxhUnc4F4DM6JPhdbzpzbNLd1u2D7Oc9in8grni1VzDTkimYyLTVdsQ==
X-Received: by 2002:aa7:9625:0:b029:1a4:3b48:a19c with SMTP id r5-20020aa796250000b02901a43b48a19cmr5058264pfg.13.1610586270067;
        Wed, 13 Jan 2021 17:04:30 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id l8sm3839646pjt.32.2021.01.13.17.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 17:04:26 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:04:19 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     mholenko@antmicro.com, kgugala@antmicro.com,
        linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v6 0/5] drivers/soc/litex: support 32-bit subregisters,
 64-bit CPUs
Message-ID: <20210114010419.GD2002709@lianli.shorne-pla.net>
References: <20210112173144.4002594-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112173144.4002594-1-gsomlo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have queued this for 5.12.

On Tue, Jan 12, 2021 at 12:31:39PM -0500, Gabriel Somlo wrote:
> This series expands on commit 22447a99c97e ("drivers/soc/litex: add LiteX
> SoC Controller driver"), adding support for handling both 8- and 32-bit
> LiteX CSR (MMIO) subregisters, on both 32- and 64-bit CPUs.
> 
> Notes v6:
> 	- split out s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g change
> 	  into its own dedicated (cosmetic-only) patch (3/5).
> 	- fixed typos in "main patch" (now 4/5) changelog.
> 	- fixed typos in comments added via patch 5/5.
> 
> Notes v5:
> 	- added patch (4/4) taking 'litex_[set|get]_reg()' private
> 	- additional optimization of [_]litex_set_reg() in 3/4
> 
> Notes v4:
> 	- improved "eloquence" of some 3/3 commit blurb paragraphs
> 	- fixed instance of "disgusting" comment style :)
> 	- litex_[get|set]_reg() now using size_t for 'reg_size' argument
> 	- slightly tighter shift calculation in litex_set_reg()
> 
> Notes v3:
> 	- split into smaller, more self-explanatory patches
> 	- more detailed commit blurb for "main payload" (3/3) patch
> 	- eliminate compiler warning on 32-bit architectures
> 
> Notes v2:
> 	- fix typo (s/u32/u64/) in litex_read64().
> 
> Notes v1:
> 	- LITEX_SUBREG_SIZE now provided by Kconfig.
> 	- it's not LITEX_REG_SIZE, but rather LITEX_SUBREG_ALIGN!
> 	- move litex_[get|set]_reg() to include/linux/litex.h and mark
> 	  them as "static inline";
> 	- redo litex_[read|write][8|16|32|64]() using litex_[get|set]_reg()
> 	  (compiler should produce code as efficient as hardcoded shifts,
> 	  but also automatically matching LITEX_SUBREG_SIZE).
> 
> Gabriel Somlo (5):
>   drivers/soc/litex: move generic accessors to litex.h
>   drivers/soc/litex: separate MMIO from subregister offset calculation
>   drivers/soc/litex: rename LITEX_REG_SIZE to LITEX_SUBREG_ALIGN
>   drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
>   drivers/soc/litex: make 'litex_[set|get]_reg()' methods private
> 
>  drivers/soc/litex/Kconfig          |  14 ++-
>  drivers/soc/litex/litex_soc_ctrl.c |  76 +-------------
>  include/linux/litex.h              | 154 +++++++++++++++++++----------
>  3 files changed, 119 insertions(+), 125 deletions(-)
> 
> -- 
> 2.26.2
> 
