Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906392CFB19
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 12:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgLELHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgLELFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 06:05:04 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C524C061A55
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 03:04:18 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id b73so8518350edf.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=ptB7VjFOHXGa3Nl2TvXAUSYtLzguBp9ctPeePIRKIvM=;
        b=mjYNJ6wrOZ/8oP6erkxFQT5rWHE0geqzUr2wuhi57zBWlSf0GkHslQultnxdYadYPi
         qEZejANd1krMu6PmWcdBj9SN0R/2u1eP9ypxXDbvnBbSRTGcFQvpvp7UfdUdx6wIo/37
         EpjPqgZbSmkqle5HyZo6fvSUTTJXhBhR5n6K29Yye2N2pRYukUGwDZTLytTd5SvRQEPA
         OQbVq4MAX3YoX5NtV+la9YiDKlU2Ca9LdCmjKRxgHnmpUpi/lXHqjGXS55ayZVXsxusd
         xWVfhTi+9Y8tY71fbJFG2iPnLVRRR8k5V+ZvaSsH3DnS4M5vsGXoCb8wqIjnQk8Rp9JK
         2O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=ptB7VjFOHXGa3Nl2TvXAUSYtLzguBp9ctPeePIRKIvM=;
        b=JQOuuy2imDgIfmdQHOaFKKKfQ35YVz5M512vonI4CqCWjBkNLsUi44Z5v6f25dRRXy
         4ay8R+oO1jDHCoKCWC2dfFbJCCikRBKBS0qA2Cl4GgfDejr0QP8KU85DYWzPHrvBV90N
         BRz6dayzCDShztuVK9/SevcsZwxtVh9qRxE8/858vIl+RFtPxjLRojnJ8VMnwTL1WuRN
         IkgWI/o3HEooWJHCqJdI4h+aRMYIDkeyC5x6V/Gu5I8r673sFD1tln+5RJko7qwYEnup
         f96voWvvwgzRu29eFVKYH5yVGCdv7XvywpXkng/lFdyDAUmLswbJ40ULe3/ilzVRIuGq
         Kmxw==
X-Gm-Message-State: AOAM531iko2WjlcgbfrCrZyn03eiRs/vcaRTD45V+5faBeUnc9IbyT/W
        X2cXefbEaNC1CiyZMKDV5Gc=
X-Google-Smtp-Source: ABdhPJww6rtnhyZ6J5HO0cyBw7T7LcSslvTFiC1k1kUHZvqssKFJtXIpiRv9/asus/Ky1CQsJO+QtA==
X-Received: by 2002:a50:ff0c:: with SMTP id a12mr11701689edu.79.1607166257309;
        Sat, 05 Dec 2020 03:04:17 -0800 (PST)
Received: from ubuntu-laptop (ip5f5bfce9.dynamic.kabel-deutschland.de. [95.91.252.233])
        by smtp.googlemail.com with ESMTPSA id n1sm4963181ejb.2.2020.12.05.03.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Dec 2020 03:04:16 -0800 (PST)
From:   Bean Huo <beanhuo.cn@gmail.com>
X-Google-Original-From: Bean Huo <huobean@gmail.com>
Message-ID: <bf1ca326b432444e7d97cac7210e07d2a4ea7fcf.camel@gmail.com>
Subject: Re: [PATCH RFC] mm: Let readahead submit larger batches of pages
 in case of ra->ra_pages == 0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com,
        Richard Weinberger <richard@nod.at>
In-Reply-To: <20200911094709.GB14158@infradead.org>
References: <20200904144807.31810-1-huobean@gmail.com>
         <20200904110938.d9a2cb53a58e67a15c960f47@linux-foundation.org>
         <ef82be594709a8f954f4933968bd96888e589df3.camel@gmail.com>
         <20200911094709.GB14158@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 11 Sep 2020 13:35:23 +0200
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-11 at 10:47 +0100, Christoph Hellwig wrote:
> > Hi Andrew
> > Sorry, I am still not quite understanding your above three
> > questions. 
> > 
> > Based on my shallow understanding, ra_pages is associated with
> > read_ahead_kb. Seems ra_pages controls the maximum read-ahead
> > window
> > size, but it doesn't work when the requested size exceeds
> > ra_pages. 
> > 
> > If I set the read_ahead_kb to 0, also, as Christoph mentioned, MTD
> > forcibly sets ra_pages to 0.  I think the intention is that only
> > wants
> > to disable read-ahead, however, doesn't want
> > generic_file_buffered_read() to split the request and read data
> > with
> > 4KB chunk size separately.
> 
> They way I understood Richard this is intentional.

Hi Christoph
Thanks. understood now, MTD expects this result. Even so, I think this
patch doesn't impact MTD because the flash-based FS only achieved the
readpage. Inside __do_page_cache_readahead will use mapping->a_ops-
>readpage to read data.

Thanks,
Bean

