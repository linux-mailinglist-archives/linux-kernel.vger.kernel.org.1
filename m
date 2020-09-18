Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFA270341
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIRR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:28:02 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E94C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:28:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id b2so5724046qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HpgmTVIIkaIr3dSnikVjv7Tpc8Gx5M8NJIa6ariAHEw=;
        b=eR3SindTOzOE/HYpwlC4rPxH0J+/1FR2eXkGVhIaE7Y82Y13PeNvODp48JgW4VWykk
         Yiectqcq08xzhB8zkF7JUK5tULcZ3uCgqOJdDPj6FFCWqly+xJHVEIGeeP7ir5SKVzyP
         HCFtjTVjpBDhZmnpc7oWcJyivMAjcjCxI351uvx6lVukWrbOVJSfe2wY0aWIXM4CMkXQ
         p/qistFshUPtCsT0jor3S8STm/elfGgSNJNngK9ibEXgo4YVcj+v0wGWwoWJHsAhZvf2
         OXMdwDinyLUQSjCvj+UGMp0Ao2IPde8WZQzZOGP3DiHBblOSCPhy4u0eoNLGlPqaYXmq
         /FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=HpgmTVIIkaIr3dSnikVjv7Tpc8Gx5M8NJIa6ariAHEw=;
        b=jXRaiUi9msxP4Yg7c3D+9EXTUzzo2W/IUHvwEHU9v1XfDkNH5uHr5lkCUySgosc8Le
         YM3VsQirOl/nfr5rhb4kumveNWNQvBMEDQJayZ+s5J24/qiX96t2Os+6e3pQERvbkRBF
         TaFd9BsdJsgPXySsTlb818r7m983M/OggfhEj+XFwcBtcDnMPfb+JIC9L8SRvFMfqxrN
         92NxI1qgvdH+j+qLWCGzImbWXlTH/kCDNikWfTRju7ej+uUujutNIrSizxw4GG5B9+UC
         gjvJWfRSKasbUGzQC2H/VcjizUbcOVOCeg1C4bsP/lWa8yclIT0XPpU6bFqzgQGHGdZs
         Ewkg==
X-Gm-Message-State: AOAM533tnZzC6SOSlJExAEmFQuGyiFjiwos/O72a8amULlViLdYEQgR7
        BOEtidsF4f43XyemW0UBMGU=
X-Google-Smtp-Source: ABdhPJwAz8e/yE636I1OD5gKWM1Sl6NqkwJtEDnW3uVFhVf47Kk10HfoD8zBobZxsfY5ql/mscV7rg==
X-Received: by 2002:ac8:3836:: with SMTP id q51mr21827862qtb.41.1600450081614;
        Fri, 18 Sep 2020 10:28:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:602a])
        by smtp.gmail.com with ESMTPSA id y73sm2437539qkb.23.2020.09.18.10.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:28:00 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:27:59 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: sched: rq->nr_iowait transiently going negative after the recent
 p->on_cpu optimization
Message-ID: <20200918172759.GA4247@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Peter, I noticed /proc/stat::procs_blocked going U64_MAX transiently once in
the blue moon without any other persistent issues. After looking at the code
with Rik for a bit, the culprit seems to be c6e7bd7afaeb ("sched/core:
Optimize ttwu() spinning on p->on_cpu") - it changed where ttwu dec's
nr_iowait and it looks like that can happen before the target task gets to
inc.

Thanks.

-- 
tejun
