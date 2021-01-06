Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF42EC5A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbhAFVYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbhAFVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:24:37 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694AC061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 13:23:57 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id q10so2770836pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=B8PYbSjV2wfSDgFPLbkumGoasg34od4IBoxCKHUJkH8=;
        b=apIUtTD+RBKMiifUBV/QOKCN1DEsE1JxgWgVOT6qWD8AmqEpUmb5loa4Kv4ZINPHLU
         c9FopF7c746VzG5HysQawa09pJBxSRVGswENI7gUizRFVTeRXnCKbN8qwo0k5DAjb9rv
         lsvzhjHh+BG75/8DjRDrJZukOkXaAGCb6bgp754HzFMLKjqVJFDE0UqT/ShNPrUdA4PB
         4iuSzObdw+PZo8089ea8QbJzgWzef1jv7jflmTDfoywyC9c1Ef8zCWvV0MWmtoE166R5
         5pH8TnwWr8lAI5IMwBvkSLDFmlGbEnNZ1CLE6G33H2TZUFmfkvxanTra2rm7849asVZe
         twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B8PYbSjV2wfSDgFPLbkumGoasg34od4IBoxCKHUJkH8=;
        b=cgExB4Nst4lZI2IyGi2Tz/F2NY//U+Y4Um9c+EQ9aiiL/iuO8xBcRYhSGOQvbqnJrY
         XkINp2T/10DwdT89H3Wf23KtJ/n/Ndd6v9LQjbkgn/FnhhgLUw5MVR7iVqxbYlXdD8rl
         CfGz/xR4jFqVwFp8VEpmA50TVooYB/BGZ+3ISdbOSsXb11zZTPe3/LZZckUmujHcdO6c
         1yUiPvm2Jsv7QiXyS73TiHFVHL8vdRTyrkRgNlwyurDgzv37ZmVtG4aM4WGOtzJTqMxJ
         2Y6+ystNU1bqCFTdZS1EzelBAYbfHqsZ2AuRl5qeQ2wuu4HAVbv8XGEIvQx8dgLjcPf0
         Y2OA==
X-Gm-Message-State: AOAM531wPXAxdfjKsa+Pi5KdXFzhuHn2lbVQ+M2pHTznYoBGzp9wdabp
        KlFdj5/BdD2XlJhT7XRNctTZYXWQyWyAgw==
X-Google-Smtp-Source: ABdhPJx2tCZ3UYxiwc5oOvOFVbTW/pTurKvOM6UOaZUSA/Rl1yc3ILaQ4uytOXQR7UPwTMqhs48PU+pZ6gLOtA==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a62:9208:0:b029:19e:a15f:169e with SMTP
 id o8-20020a6292080000b029019ea15f169emr5832648pfd.71.1609968236760; Wed, 06
 Jan 2021 13:23:56 -0800 (PST)
Date:   Wed,  6 Jan 2021 21:23:53 +0000
In-Reply-To: <20210106161233.GA44413@e120937-lin>
Message-Id: <20210106212353.951807-1-jbhayana@google.com>
Mime-Version: 1.0
References: <20210106161233.GA44413@e120937-lin>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based sensors
From:   Jyoti Bhayana <jbhayana@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Instead of adding IIO_VAL_INT_H32_L32, I am thinking of adding IIO_VAL_FRACTIONAL_LONG
or IIO_VAL_FRACTIONAL_64 as the scale/exponent used for min/max range can be different
than the one used in resolution according to specification. 

I am planning to use read_avail for IIO_CHAN_INFO_PROCESSED using IIO_AVAIL_RANGE 
and this new IIO_VAL_FRACTIONAL_64 for min range,max range and resolution.
Instead of two values used in IIO_VAL_FRACTIONAL, IIO_VAL_FRACTIONAL_64 will use 4 values
val_high,val_low,and val2_high and val2_low.

Let me know if that is an acceptable solution.


Thanks,
Jyoti

