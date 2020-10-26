Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A12994E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789250AbgJZSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:11:41 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44383 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783552AbgJZSLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:11:40 -0400
Received: by mail-qv1-f67.google.com with SMTP id s17so4735254qvr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXbdbicKVeXDRSO9MY7B1zqIT3oHv+LTHNtkKPt2D2A=;
        b=c1etfYcK4UNhq0LLeOS3Fyh2e89joQELvnJVPIbaj1PWxbTphDsP0AjrZNeoBzlS5Q
         9Vc9V4DtO54YtziHvzgJd/VUGo2LkbvXnN6FWCpvWZCwCL41WH4/MztPmFEl1teTQxqw
         C4yKXYKJY5GpMxboXZzlnSt/9rCemQusXpalfDg7cf8AGFxMol3mWQgoqmtBi0TLleM8
         ge7o+r2S7KDzHYYojoADRVsvln7pDRE2hoW9STGUerFkkVbV7OB4CAO49jRvQU7eCi7c
         CRQVJmVZHnsTkA3QvN2MiHs2yvLPrafKpvtrKpRUZSx0/q56gFdFIsEuXibDEFD4svFx
         fkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXbdbicKVeXDRSO9MY7B1zqIT3oHv+LTHNtkKPt2D2A=;
        b=MzPqKIicjIDy5dQmM4LkWH8UfNa7veejeUI84Rzs2164BD5DnLDEh+kY3dzfM1oiLm
         Yc0Xl4t4ROt3mKynHIFavc4IN2v+K5EMg2ArwgLV/zfHNIU0qlyBQtxf4oXi6palMBnj
         83PIFCCQqBoqpyf2yZHQZ6LvUX/z+ixxvVJiDN6i7C3UV2QHJkveWYb5HzRN/MuhXwnq
         HQAQtMw107sj1rgwZa/adkX+fMOkKTa2yyxpUYwuLiSzoDF1cM0n0oYatcIfJSnTjtHr
         g4/bzokgpY9k6WIqq1srJ+ULAjQgAgzhzAo03jeVJhDiCSM5r0ZMmrv4FVjbA+kVrYTV
         uzNg==
X-Gm-Message-State: AOAM530wa6VovhIgbNvMC7Ion6463cUZt6FKdh0qlEgBPFaZymcq9+Hw
        72v5QalVpC6U0wo5UZ4jw+fSozoPewfarLNA8Qjl
X-Google-Smtp-Source: ABdhPJxCVt0hlOpjCr4DRBoxaQZuxsKFgDcYuSZvK1o2Qz94wNBVxtgEEFyFN1OHIAFTWCkpOw8UBiG+JoZum53bHpE=
X-Received: by 2002:ad4:46a8:: with SMTP id br8mr18327630qvb.24.1603735899186;
 Mon, 26 Oct 2020 11:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201023150536.282568-1-98.arpi@gmail.com> <20201023150634.282631-1-98.arpi@gmail.com>
In-Reply-To: <20201023150634.282631-1-98.arpi@gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Mon, 26 Oct 2020 11:11:02 -0700
Message-ID: <CAAXuY3q6c3d5kkLOqsG2LBmBYS4d9qRuEeZ2ChpJF1OVTkV5gw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static struct timestamp_expectation test_data[] = {
Can you mark this and the rest of the hardcoded values as the const they are?
