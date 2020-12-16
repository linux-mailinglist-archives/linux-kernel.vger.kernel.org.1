Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021472DBF11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgLPK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:57:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54707C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 02:56:23 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 23so47200975lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 02:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Ee6BEPzW0avC5vdfdajiCFDdnJS72+HuNB+ehIuHbk=;
        b=hFL8jZdRErw+2q0idCTbKwvhfx1cxsgiZna0h3pK9Iqi/2E6wv+Hp9XLgECsN0cdVq
         CTrl4XrF4+1l3LXlIc5YVVX3ycdD0E4bYGTgXA/ofj7HLD80VxwL7UipS2uHkOy8nKG6
         3d34JFGFEm4o4yIRjEcYtxiYTAyE1dq5Yy4zD2mJxTUyBj80indDaHOpSymMmYUwkvfP
         jXJNAjngb1zAGUzXfwjYkM76vaLVewW/rSyPc1LHYV/X4YSF40GWng8Ihweixkg2F9d2
         3fhZgwiYGKffpQHKzLGbiW1IGHQvx9zOxCzH13ALA7vxmuiBLHu+Rywe9GIf+Ya3+ZAj
         g7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Ee6BEPzW0avC5vdfdajiCFDdnJS72+HuNB+ehIuHbk=;
        b=VxFGOSwekkKz6fr4ZBoUNtyno71Sgka/N7GddrCswI3cn5UyAwYQyTiM95G8KxPl5+
         I3VHBkxjWP/RQxCVTv0vO1Zw0usF6k7RccYotY09F/TElDmIggmdrE+OqqcfSgzC2tkn
         NimmtFYBnokfyETXB6bzBfpCLIWcDfR3sfzTdn8WMlac25GR+sZBPcjhJGjYQp9bbejR
         lonxiomXUZlg0D9P+sFUVpE1GRV7QR5uVz8obXJDui+0FPIw86VrcbTuIVoGIlI/ox8Y
         tGh47u/GiuC87ERdAanrLvtvRgbbotZIRv9THvPor9mbfE9XgvvDF2iVSggx5fQ0jRS4
         AeAg==
X-Gm-Message-State: AOAM531sSrQ1V4u5Eb1nvFGKvNmHfRHp87UsRKWt0EOcfv1NsRWD868n
        eXPZwIPN07zHbcPVUu450JqSsw==
X-Google-Smtp-Source: ABdhPJwjBm4DQ8Kg+Djp6Z8MIUqAiwyOQ9W99Mg2Nb+MDWSBFOIbtMD8LyGy1mcdwghm3XdFhqmN0A==
X-Received: by 2002:a2e:7813:: with SMTP id t19mr14943140ljc.87.1608116181872;
        Wed, 16 Dec 2020 02:56:21 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d24sm185353lfl.30.2020.12.16.02.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 02:56:21 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 92CA41033F0; Wed, 16 Dec 2020 13:56:23 +0300 (+03)
Date:   Wed, 16 Dec 2020 13:56:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: increase pgt_buf size for 5-level page tables
Message-ID: <20201216105623.e65a43mhegoqgldt@box>
References: <20201215205641.34096-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215205641.34096-1-lstoakes@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:56:41PM +0000, Lorenzo Stoakes wrote:
> pgt_buf is used to allocate page tables on initial direct page mapping
> bootstrapping us into being able to allocate these before the direct
> mapping makes further pages available.
> 
> INIT_PGD_PAGE_COUNT is set to 6 pages (doubled for KASLR) - 3 (PUD, PMD,
> PTE) for the 1 MiB ISA mapping and 3 more for the first direct mapping
> assignment in each case providing 2 MiB of address space.
> 
> This has not been updated for 5-level page tables which additionally has a
> P4D page table level above PUD.
> 
> In most instances this will not have a material impact as the first 4 page
> levels allocated for the ISA mapping will provide sufficient address space
> to encompass all further address mappings. If the first direct mapping is
> within 512 GiB of the ISA mapping we need only add a PMD and PTE in the
> instance where we are using 4 KiB page tables (e.g. CONFIG_DEBUG_PAGEALLOC
> is enabled) and only a PMD if we can use 2 MiB pages (the first allocation
> is limited to PMD_SIZE so we can't use a GiB page there).
> 
> However if we have more than 512 GiB of RAM and are allocating 4 KiB page
> size we require 3 further page tables and if we have more than 256 TiB of
> RAM at 4 KiB or 2 MiB page size we require a further 3 or 4 page tables
> respectively.
> 
> This patch updates INIT_PGD_PAGE_COUNT to reflect this.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
