Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1000D287567
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgJHNr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgJHNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:47:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB85C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:47:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so5080335qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZmphTjf8HGsXVtVKxQAe/wWYWlmSU0hlqD0LnkO9/ac=;
        b=IxEtDN49cKxBfMEZCUSn9v3ivKPNohDxOz3G/JZZkKQX8nHmHKVopjQSntd918b18h
         EF1zmRwY//m/RjY416QBXhCXetzVGQkbk+bodmNgQyaH5dJk6w5mYjP6jjBMUFNStDUp
         deQb+cWVF2fgavlYQ9QoOvLm0mOm+qFT32DFznS0gLl9XDK1q+xyCaf66oe7IAybYtmu
         vHW0sR/IU4w/zxPeYZk/Ea2wAruY2d5b8EJOuvMptFvE9mxCY7AS5NN/5rBDPb77l2ge
         WVBAOIo1MZHqEKpBca3xL675B2siRGpGfG3VK44O4uCipsoueAXJiQlRIT+zACLDaAq4
         LYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZmphTjf8HGsXVtVKxQAe/wWYWlmSU0hlqD0LnkO9/ac=;
        b=gsZPqeWM1Gq7KA7Q9nLQYkg6hxtqj0vgCkwcVy1PX0V4NQgv9syrCUumZwOcOKszhN
         BssbMMldyVDxDlN+0kJA/Mqp28OkPSu039YZThEpYa3HqU+DpEGN4oD/5QtiPvmYW0UJ
         M8OQiclOifCFXU40BAMYoVr1HSZc1JPHwJqczy5WAl5AuilDp+BtKJ0CXcS3vL/kZDqm
         BaO0faSkN1z4zVK+AxDXP8witj6kMMOsbbBLwqS0O9e5Vag7jN/V9sFsioowp4Cr9Ufb
         ZkRDLOFp7/ShKMJsbew8CoF02+97QTDPinfVWprHnQrceoori+e5SDTX05bQp30eTWKv
         mUDg==
X-Gm-Message-State: AOAM530d2Mn9pNcVzJ4+QthDmkJtUxvZzBORvoGiykSHY3tsRyXG51oD
        VXkMmEaU1yc3hyI5sXl79yQ=
X-Google-Smtp-Source: ABdhPJwSWxnNwq5fHdDTtAP8YVTm0lKNEZAb0JQDk8poz5FgkJBvNfoKfuwVdKdm7W0uvoTOr/XjzQ==
X-Received: by 2002:ac8:4d03:: with SMTP id w3mr8592759qtv.360.1602164845750;
        Thu, 08 Oct 2020 06:47:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l92sm3864150qte.38.2020.10.08.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 06:47:24 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 8 Oct 2020 09:47:23 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/boot: Move get_cmd_line_ptr() and
 COMMAND_LINE_SIZE into misc.h
Message-ID: <20201008134723.GB2429573@rani.riverdale.lan>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-3-nivedita@alum.mit.edu>
 <20201008093042.GA6491@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008093042.GA6491@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:30:42AM +0200, Borislav Petkov wrote:
> On Wed, Oct 07, 2020 at 03:53:48PM -0400, Arvind Sankar wrote:
> > Move get_cmd_line_ptr() and COMMAND_LINE_SIZE into misc.h for easier
> > use from multiple files.
> 
> Well, I don't like that. cmdline.c *is* for cmdline-related things.
> misc.h is a dumping ground for everything but the kitchen sink.
> 
> Why can't you leave it there and make it visible to other compilation
> units?
> 

Are you ok with the include of setup.h?

I made the function inline because it's a tiny function, but I can
simply add a prototype if that's preferred. KASLR does use it as one
more memory region to avoid, rather than just for parsing the command
line.

Thanks.
