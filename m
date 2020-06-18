Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85071FFA10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgFRRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 13:20:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43539 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbgFRRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:20:55 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so7921097iol.10;
        Thu, 18 Jun 2020 10:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VH8S2v7O8diZS51/azFiEAEdYRzI1ehg79BFv839KHc=;
        b=GvqDJdsTQuUHRHA2BBO2DzswubLbXGgWNk0opG9MK4spBA9O5Qj089dAIHq4Ozt22C
         cpkjIo2XtlCJyMzcs9WWyEb9eUbaLnJjBu5W5SqaAf/eeixWjo9OY6lDhkjJ2Av+cWQU
         577P9rahSOt/5Zf309QUXP67pajxUMq+4lYxqkeE20VTK6GDFEnWhVbY1iYNkWhyaHzB
         ZfNlfkHKNKo0HjFle0oWvpYY+r5zAaj8dUqRAKIhP0iiNxWCzmkAIk1qaT2bjDgK11lO
         DVl8GK3g2zTW2YDGM/laFYn7ep/ex39irjkUu0ktmCrBeiZPXi/bxnBPOx+YbvF26rox
         KcIQ==
X-Gm-Message-State: AOAM5332v9yt/+rOjjLuLMUXaQyNfWiRMT7jpsrDZ1sV7kcWHSaFzQ7h
        f8r8mLkVU3OVV1vzVONP7A==
X-Google-Smtp-Source: ABdhPJyxO5bc/mOKqhGBEaIj5NAcpWG9wYgFOjedTsxJz93sZ6cHC5TNkIg0xUBUJ1tUVM5f+CLABw==
X-Received: by 2002:a05:6602:13c6:: with SMTP id o6mr5924431iov.84.1592500854999;
        Thu, 18 Jun 2020 10:20:54 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v11sm1806720ile.61.2020.06.18.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:20:54 -0700 (PDT)
Received: (nullmailer pid 561584 invoked by uid 1000);
        Thu, 18 Jun 2020 17:20:52 -0000
Date:   Thu, 18 Jun 2020 11:20:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 27/29] docs: dt: minor adjustments at writing-schema.rst
Message-ID: <20200618172052.GA561010@bogus>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <14fc680fd6596b277f94bb5a240cc9dfc41d59bf.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14fc680fd6596b277f94bb5a240cc9dfc41d59bf.1592203542.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:47:06AM +0200, Mauro Carvalho Chehab wrote:
> There are two literal blocks that aren't mark as such. Mark them,
> in order to make the document to produce a better html output.
> 
> While here, also add a SPDX header to it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/writing-schema.rst | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied, thanks.

Rob
