Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D722F219E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbhAKVQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbhAKVQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:16:17 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C6C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:15:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z21so492pgj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eImIXVcmQBsUdAK4nUs3QzMFY2oOA0m3xFBAZ5UlarY=;
        b=R45U2GFxpNKrX41PGBtjVajNizJ+L1fdCS2kja7FZhXTDpmkDcnjjhWOzc0s4+B9iU
         SrkqLqZyjomsaSSssGN7aSfLlFbzjls4QacLHJt4+TomaXxeIWi+pjqxi3WLy/YrqsuZ
         Hob4GTFvV8ZP2ZteUermm9mhUzg1LMYo1IZAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eImIXVcmQBsUdAK4nUs3QzMFY2oOA0m3xFBAZ5UlarY=;
        b=gv6yFGu7w+cFaJOxKxyYfL8fxLJBplxLuwAIx+GQanfrdvaYyr0xVmddon/PauSO3i
         wnEP8JQhb9x9blrNRuG93A0TSCtHWf+GgEGrTM5ZY0vH9P63xXVxaGuvClxnfdMufOSz
         IAlV5eAssjS8CC71cAuORt1ktg01Hkdhv4ypfo2vnrNeTM0UKrwpkgCQagGbA5RCQkAm
         zaYBmUaM9PIwbwGVDdxstbu9JPHYuvfhRh01Y6SvaO74i0DDZlo2y/PmX5thI1QhQk8z
         Lx+c4HU7ijdz3icEb+DtsAT5WtAazsWGQi+l7FS5A+9iB/bGGy2CfT56c8MmuJ4h18oj
         6nOA==
X-Gm-Message-State: AOAM5320CKRFfo+ma2wU0MkkgDmeq08D/P159awfJUQPbCUFDwFJewqH
        8XYmxmIxp2U/xOR93vqBqEqJGA==
X-Google-Smtp-Source: ABdhPJyYRrUdzSBIlB3avvXXdqGTz1ujQ/vNTvIs7q2sEl7k9jzEUxtm/eAwpD5L16fwLRw7+MKdCQ==
X-Received: by 2002:a62:2585:0:b029:1ab:7fb7:b965 with SMTP id l127-20020a6225850000b02901ab7fb7b965mr1308806pfl.2.1610399737104;
        Mon, 11 Jan 2021 13:15:37 -0800 (PST)
Received: from cork (c-73-93-175-39.hsd1.ca.comcast.net. [73.93.175.39])
        by smtp.gmail.com with ESMTPSA id t4sm526934pfe.212.2021.01.11.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:15:36 -0800 (PST)
Date:   Mon, 11 Jan 2021 13:15:26 -0800
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        andreyknvl@google.com, jannh@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH mm 2/2] kfence: show access type in report
Message-ID: <20210111211526.GB842777@cork>
References: <20210111091544.3287013-1-elver@google.com>
 <20210111091544.3287013-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111091544.3287013-2-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:15:44AM +0100, Marco Elver wrote:
> Show the access type in KFENCE reports by plumbing through read/write
> information from the page fault handler. Update the documentation and
> test accordingly.
> 
> Suggested-by: Jörn Engel <joern@purestorage.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Jörn Engel <joern@purestorage.com>

Jörn

--
This above all: to thine own self be true.
-- Shakespeare
