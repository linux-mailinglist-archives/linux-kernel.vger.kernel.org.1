Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69EB23083C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 12:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgG1K5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 06:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgG1K5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:57:32 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13ACC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:57:31 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dk23so8311183ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZmQ3dkwrohmJdjRb+T+ntOxqQdIdD0pDYwQoPTPtnBo=;
        b=SrFLQ3/XqSIUt8W/CB7ZwPcVQHOAyNfAAwEdoHSWUQsaz1fheSYLb49l9yVXWmkQjw
         vc0KUKexpJ2W+DgPfEAwZ9B4U/PN01/Tu0NVHZBKMZY5NO+GFqf/BevC3MLwdtVYdttB
         UTxBjYCeooNvyPV2DySXjvLbdFmZXjKqMfKzy9EGhRj5OzJ9rA3r4Bca9KSSjBFcnvD8
         PB28BGihHXu0aXeTR3dcbE6MnKgt0s5xFwqTsUFHSqzdkkUsc3P0Ke0jPZL/KN7skCTh
         McFzqTsTKzm7V6fTV943bRirmw+iTkwEJmSHg35l7F8N9YXP/D13OBy5ojS9pmSoj+Te
         e2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZmQ3dkwrohmJdjRb+T+ntOxqQdIdD0pDYwQoPTPtnBo=;
        b=tq0Uov+gfViv8rq7Zyma3SkFsrQmSqJ2x5e5v2mT7/ujBpSRSzhRjvPJ4HgpgzQjZQ
         hUcZaDEhsG0b4Q1z/Q2tuoUi74K+Klla/P7foexOhVxrUVynsRbVtJG7LKDkG02x5H2e
         vMx6WzrUky8uSIs9mg6VmDMd5PnUITCCbnClV1xMtgnxwHVViHCB6WiMGMp0Tuk4f9bP
         wl5wcx8/ZMcJnnWFfhKOS32n0fKo9/xAuuKloeiZ3X0XrOdMJFzDfSjkZLlIcXJe7IS1
         D8q8GTxs4VvavX1MOInZpid0F9JauV82eos1AsgX+pifvOg1INmLPZcAnHIsKok7gp1M
         Qvuw==
X-Gm-Message-State: AOAM533NCq3waWUS9PiCRS6ZgpDXWIWyYMM5wJUtjQyzfAjoCU9VFVsX
        QvFsysNdhCUlQQqFVezdIZs=
X-Google-Smtp-Source: ABdhPJzbso46BRXFiIITHCOBcbcfUVaVfaUZSQaIOAeeJWxfGQ+d8ozyN3pw2giVhMIFtW25suoKJg==
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr17112464ejx.212.1595933850672;
        Tue, 28 Jul 2020 03:57:30 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h24sm8840984ejg.53.2020.07.28.03.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:57:29 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:57:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] x86/kaslr: Simplify __process_mem_region
Message-ID: <20200728105728.GB222284@gmail.com>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727215047.3341098-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727215047.3341098-6-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> Get rid of unnecessary temporary variables and redundant tests in
> __process_mem_region.
> 
> Fix one minor bug: in case of an overlap, the beginning of the region
> should be used even if it is exactly image_size, not just strictly
> larger.
> 
> Change type of minimum/image_size arguments in process_mem_region to
> unsigned long. These actually can never be above 4G (even on x86_64),
> and they're unsigned long in every other function except this one.

Please split this up into 3 separate patches. The KASLR code is 
difficult to debug, so we want to approach changes as conservatively 
as possible. This is also reinforced by the fact that this patch was 
buggy in v1 already.

Thanks,

	Ingo
