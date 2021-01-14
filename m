Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737A12F6E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbhANWcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbhANWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:32:47 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:32:07 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 2so4755436qtt.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QOaxopk0Vt0c18C4pnEsewzOIIMzXpSpyDsCoJ7fsp8=;
        b=q8oWVjd1InoXRxycK2EAtoJD3bQPVAxcd3GoFRwpJn0sE/nyS67uW0rt9eyjm8vBAF
         gZ7/JTJbdSWcSDBeCTxvFDSHrAff1sI/VytZOwveMZ+T4K05m/JlniBUbiO5ZYhNSO14
         tyb9Fs2TBXrDqa5sNsU+n7S9+X4ysUN5hFn0k/FSoW29mAW2j5kRA9wfc/zvhjH7Gjx+
         PbxiyJgwHczWiCFKM5MGgXxk8HZqqBn853vIAwBDXS0r4HrRtuPsvdoPDt+SoqvZ9soH
         874OqqatQIErXiOG4PfOh0Gxl7k6ynPKcnDgJHncg2hgT6qmNuDEGVGunZr8R00IukxV
         iilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QOaxopk0Vt0c18C4pnEsewzOIIMzXpSpyDsCoJ7fsp8=;
        b=Ceg2Rm2o9HZghv84Gtv2IT0ycDLxUIbGoQ41WltzWjlkfTiI57Pcil+v9B+w2XDAeh
         Hi36KyNDovE2qeVdd2dFp9YRWiFpXiltUd3JT63OHfN060PQwEaA1BJEOLAD8V+uLQNN
         SikDpijL91zBFl2LHxcqRpMkeoagwaB5g8aADc/e6UAtr//PckoPpa2tiBNo1OyIv7Uf
         PhibVEnhh9Ay9cXkd8R3BvSLC9OMaSXxY5p1hJlppBqbl6J2oZFSEjSqcc68Vxc6QZXH
         9LvDW6cpYI0VgNA8ZSXu98mI0CzD7TNxLFh2xH0xN2vZen99Sr6l0rhreBoU8IZA34mk
         yzMA==
X-Gm-Message-State: AOAM532d16bH9XtTA3rTbbFR3az8g3eti4JW6hd4y3tDkyV8iCkk71DR
        2o68AuT1EnHaWn1bVHy51G6L7Mm2ERg=
X-Google-Smtp-Source: ABdhPJyY4iG6EexL1Lir6Z9FvhhSK8QIPxQ45WVsdWgyNPE2xfVn0UjntfzThCh0K9LNDF9AJIiP4w==
X-Received: by 2002:ac8:b07:: with SMTP id e7mr9295700qti.311.1610663526257;
        Thu, 14 Jan 2021 14:32:06 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 195sm3875947qke.108.2021.01.14.14.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 14:32:05 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:32:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] objtool: Don't fail on missing symbol table
Message-ID: <20210114223204.GA1984019@ubuntu-m3-large-x86>
References: <a96c3f76173c7021a2298bd73362313736e674b6.1610663051.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96c3f76173c7021a2298bd73362313736e674b6.1610663051.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 04:24:15PM -0600, Josh Poimboeuf wrote:
> Thanks to a recent binutils change which doesn't generate unused
> symbols, it's now possible for thunk_64.o be completely empty with
> CONFIG_PREEMPTION: no text, no data, no symbols.
> 
> We could edit the Makefile to only build that file when
> CONFIG_PREEMPTION is enabled, but that will likely create confusion
> if/when the thunks end up getting used by some other code again.
> 
> Just ignore it and move on.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks for the quick fix!

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Is it worth a cc to stable given that I hit this in 5.4? I suppose it is
not super critical now but it seems like someone might eventually hit
this as times goes on and binutils 2.37 becomes more common.

> ---
>  tools/objtool/elf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index be89c741ba9a..2b0f4f52f7b5 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -380,8 +380,11 @@ static int read_symbols(struct elf *elf)
>  
>  	symtab = find_section_by_name(elf, ".symtab");
>  	if (!symtab) {
> -		WARN("missing symbol table");
> -		return -1;
> +		/*
> +		 * A missing symbol table is actually possible if it's an empty
> +		 * .o file.  This can happen for thunk_64.o.
> +		 */
> +		return 0;
>  	}
>  
>  	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
> -- 
> 2.29.2
> 
