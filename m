Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F228BC09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbgJLPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388881AbgJLPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:35:05 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F16C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:35:04 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id b19so8550445qvm.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rZy2BE4vWe0WATq26ASIIAcpYFJbKzsyX+WqgN7Rz9o=;
        b=PKk7kuvwqT+rrvREsw9cIK4NHOIHIwLB+51FV9UANNJodmcbHP53c1OTu5IEbLdzEj
         cSTBXfCmtDQCvwxSuDVjH3ALTSbcFVPHCh422oN3PRfy6ExBxwn1xGnJr0tryEOMdJIU
         qdSh2tDcG8c5S4ubM8+6pR6QTS6AE3R0YiNjHycC4yQPwj96TvGf1HVFS8O2TaD9Jmel
         kwpw69GLNApN2F7/T2IcKhuipeDE6OeswPv8r1/H9fntFDRjpIZXkCgNwpvPGRugj3Mv
         mBOWWOxdqeLyNf/YNQR34tJVN7L3ZFPc5EdKOIOttT+KH+NYTPHm+9W9ohuyGE3ELxrN
         AwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rZy2BE4vWe0WATq26ASIIAcpYFJbKzsyX+WqgN7Rz9o=;
        b=WMmEEu7+SMRz+RKZ04W3oca4WeJYwU6NfvWs4TBgZgeUorXr19o26AV8jIHNgqAeyp
         Tv0nAWMOaywmfAth9brHhUhqe3XaPjGkjT3JbD9wKceK9lXC+j1UGKxepvLWI+dEGFFX
         Mxpw4YooaVNLfTXotWEgSx23jWCwwzV36DqK3Ap/6NJfz2qcneuoqTuZovizMuileW8c
         aSFODLbD2bNqlDByUa6VBKbRE2IX3iFLBti0kr47RvPjJY/p0DbcokWTsvARnsO80VVQ
         VwhUvqIecsjgZ9FKrRUUPcAVFw4PzU2o/XgNpdjNmWvOwfF/Rh+QThr27/VBY1qhoaRf
         6EYg==
X-Gm-Message-State: AOAM531+cuqyraTkiwNIxashpzENuk5Fxc4YEnVlJM2NuLO3wA+l5GIE
        4pBGo9QuIQQV16JLL/geJNhzuCVRWV9BLA==
X-Google-Smtp-Source: ABdhPJxv854oW7bKA8EGnpqpNlg1LXuCiUtIJDwMSF8OInFgxLViEEzeIiliBfbNYDDJavFTWghNqw==
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr16902164qvv.42.1602516904145;
        Mon, 12 Oct 2020 08:35:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t3sm12697807qtq.24.2020.10.12.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:35:03 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 12 Oct 2020 11:35:01 -0400
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201012153501.GA559681@rani.riverdale.lan>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
 <20201010192624.GA4062867@rani.riverdale.lan>
 <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012140830.vrc25x2gwo7yo4kn@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:08:30PM +0300, Kirill A. Shutemov wrote:
> On Sat, Oct 10, 2020 at 03:26:24PM -0400, Arvind Sankar wrote:
> > On Sat, Oct 10, 2020 at 03:11:10PM -0400, Arvind Sankar wrote:
> > > Commit
> > >   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> > > started using a new set of pagetables even without KASLR.
> > > 
> > > After that commit, initialize_identity_maps() is called before the
> > > 5-level paging variables are setup in choose_random_location(), which
> > > will not work if 5-level paging is actually enabled.
> > 
> > Note that I don't have hardware that supports 5-level paging, so this
> > is not actually tested with 5-level, but based on code inspection, it
> > shouldn't work.
> 
> qemu supports it. -cpu "qemu64,+la57"
> 
> -- 
>  Kirill A. Shutemov

Thanks! On QEMU, it does crash without this patch.
