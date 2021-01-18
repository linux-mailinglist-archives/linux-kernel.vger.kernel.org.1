Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475642F9A44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbhARG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbhARG5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:57:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E6CC061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:57:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id f63so1834471pfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/gluZUdXxWJf3r6BZqyyjnO+KL/Ab5/mk7/bC0aKLm4=;
        b=KjZrTh8XQgItnmM9oaeLcxC7WN5sMZikMcBi9gOEC2jizb6SJYY/9mIlqrM+uTmPgX
         agtUG0bu4KZeTBXelftKmei+HOOMLAGBv+ZSGMOrASJ6ET/uolU8r9IYV7Nw+gjZW8JD
         HZQyNVy42+ClehEyDATgfZtcmOAUkJiN85cx4PuHqpBTjTY8nMYRk4fGqzCGi7+FNOOA
         YOoQukNfWSI20rlmwsxDIP72j/m8u8EfqMRzavENjas4mjXJGcTix7l2mYyc2jbmAk62
         ny33X6nv8cc1rKlCUUZrdDIn+XevPN/srG1ZD9pY0akVJtWYO7Nm9uz1JSlsDpLsBpqP
         PgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gluZUdXxWJf3r6BZqyyjnO+KL/Ab5/mk7/bC0aKLm4=;
        b=NlF8tHOWRHoIc1S3Zg2Xl5YjDTuhPmu47hEnxvUvdwiJ4wfwh/tbfcaNuuLQyvlYL9
         1d6LIXKE7VcZo/UoNPXQcS47TrKigU/gFsuTBrcMbs4j9B8arA3lvjsflk4CLdtl28gV
         8LLRLk1TRSzkoCcfW7a3z5Ul9QDT9ZV8n8SJ6MTVOLSYzquJvgfxQcCCWejRmuIrX7G7
         tXczx6Qp3jXmUido0AR1wdiUU7eZ7+a5hmE/UMjX/0HPnwO27SOcY4SJVDGZp7RGC7Zs
         OWn+l8lvK7tFyddtCmIKwI6DU+32z04M0RU5vAVJT+8KYj4PN/E+hOTecZPn+ycSecDX
         8V6Q==
X-Gm-Message-State: AOAM533y3uW1kiiCZoW/AEhg30ja8pc9omuGJ/rDlTdytGYxU8GPTWUe
        OLQUABoBQ7CVaKZhTTw5ULYoWA==
X-Google-Smtp-Source: ABdhPJx6WcQLEt09vtf7Tq0fEQfa1sBZU3JTh5QwJhr3FrvYQ34qgGS/DZ1/EUyQKxU4B15RjL2q6A==
X-Received: by 2002:a63:1b1e:: with SMTP id b30mr24762455pgb.421.1610953025278;
        Sun, 17 Jan 2021 22:57:05 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y26sm9840259pgk.42.2021.01.17.22.57.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 22:57:04 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:27:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Robert Richter <rric@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] drivers: Remove oprofile and dcookies
Message-ID: <20210118065702.2hquoixuhim5jsop@vireshk-i7>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <CAHk-=whaPiPCM6erqqe5Q-Ugn7u-jY6w7iA-kEBBc8aB40sBoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaPiPCM6erqqe5Q-Ugn7u-jY6w7iA-kEBBc8aB40sBoA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-21, 09:51, Linus Torvalds wrote:
> On Thu, Jan 14, 2021 at 3:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > This is build/boot tested by kernel test robot (Intel) and Linaro's
> > Tuxmake[2] for a lot of architectures and no failures were reported.
> 
> Can you make sure this is in linux-next, and we'll get this in for 5.12?

This series is in linux-next now.

-- 
viresh
