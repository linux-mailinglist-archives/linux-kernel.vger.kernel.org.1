Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B28283BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgJEPuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgJEPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:50:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F766C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:50:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a17so10452pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QdwCfEAqR963uJIdGXq3EhZ3rN4/0H5cNJx6SpjwftU=;
        b=jiMa85QUHzkCjUIfp6utJy2vvdtMAf3NUrHuPwPRYducW8kCt4rg+AiNPQEdLZd0Nz
         0HSGPS1iP/p4mvGWhBKlMxjCv5/yPtIIF/E6zLVeQqsgI8PWgxbkWSCled1QcOea/hx4
         BFcKR7ibXnEZVtPvJ3RbfRMicUn7DxHRilgC+7Wk0kw3RiEmU8aUJN/8hg7riIFCeq8Z
         eEVG06lfIpEqTcdj+5YiH7GnNXkz01DV09Gs4gEIu2yCUIKR5TuHSLSLi61tkf7E4Ama
         XgH9HCHZgbg8o65eBYpD7pWhMw3bNdIgnsVipE2qyhQm2Z5GrgjQkRTaGR8zWDo9EiXO
         XOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QdwCfEAqR963uJIdGXq3EhZ3rN4/0H5cNJx6SpjwftU=;
        b=gD4xsdXr250GZLs0VtV+v1k2+6blkedRh16OU2wn3cvp6aQxmX7eNwSSFZ2AIBoIu0
         oxpsRb1vdKsfwYu1UZwAciDVqTIZ6Qs1jKQKGjh9z6sgcSBnvk3wM2qMUhcRCvkp/pEw
         5RBB5Jfj9KaiRHVnU9JV0YFBWr+ATwJLafIUD8O9Za4BFQ8ln+RQQJJbP+bFZYZHCpcM
         fqb0dQvPSpxQyTteN0pd5na5jcybdpRF9rxiROA2d+d0I2mboqM20SNzPM2t51brjJdy
         guPflEx8uAufon6DlxYZUUG9q2KdP+ARq+G57+zxOBb+AmyOafW2nrPboRDRkNE33qdf
         k4Vg==
X-Gm-Message-State: AOAM530XYfqAqK//fW+txx8uQVisP0YHhyi2eBM+NIaFALWiL4IQSxsd
        aLVtp5ABeJTSQmIk61ShxHrX4g==
X-Google-Smtp-Source: ABdhPJziyWUsU/P0WBOVsS8oI+XCQF+q1Wx6sa8YPdI90RdzXPzMdv3StOgiNsCH5FKQTVJP3Wuy1w==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr435465pjs.195.1601913019937;
        Mon, 05 Oct 2020 08:50:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z6sm371042pfg.12.2020.10.05.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:50:19 -0700 (PDT)
Date:   Mon, 05 Oct 2020 08:50:19 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Oct 2020 08:50:17 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Fixes for 5.9
In-Reply-To: <20201005071632.GA14204@infradead.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-a46c3a63-8060-462a-a564-719c5d95df2c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2020 00:16:32 PDT (-0700), Christoph Hellwig wrote:
> On Fri, Oct 02, 2020 at 09:07:27AM -0700, Palmer Dabbelt wrote:
>> * The addition of a symbol export for clint_time_val, which has been inlined
>>   into some timex functions and can be used by drivers.
>
> Err, haven't we just agreed on that this is a bad idea and jitterentropy
> should not call get_cycles()?

Sorry, I hadn't seen that when I'd posted the PR.  It looks like there's a
jitterentropy fix in the works, I'll drop the export when that lands.  Probably
best to talk on that thread, though, as there's more context over there.
