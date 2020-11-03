Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5A2A39FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKCBpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKCBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:45:08 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD5C061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 17:45:08 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id n63so5133622qte.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 17:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version:date
         :message-id;
        bh=cjxoNYxbu1+SaqzoPnce/Hs00JITYfxQWTJFm6SDY4M=;
        b=BCTlhAur6u1VziO20eWewM72Cq99of9KTcxc+w2vZ0WNhghROr6RgNmHg+bPeyfjVq
         pKzPI8wSjYmyK1uhNnfQmGkrThVhveQat+Ol8Hm1oWwu/2JJWw2JbbgWZycUMjDpZkPa
         litzC4Wx9viykurVhIazVRf/sJXFLJkBfBYP3ws5KMXjzPxpMXnDdPFH7tdm0SnAxTBy
         y6YGezR6s7odPABA7MAdIfkKvQYoSYSEZ4qL01qB5WUNIlCqCc0vxNtyPVQHyrPhGOWO
         zf7FzkY2LzCk0NX//DLRcj9k9W32HfmlowLemoQhispnI4jEr3gqHG5m5HZsXd72SEkO
         rciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=cjxoNYxbu1+SaqzoPnce/Hs00JITYfxQWTJFm6SDY4M=;
        b=pH33sReC+8bQkoiXynDNoLVBWGiN+hrzxe/VlNcMS9b3kypOk+XW+tD1PV+poZPh0Q
         vMF1DH+u+P1BXd2EXOjKpfDj1hzz7wct2IA8qFPkDb7Ih0tQtSdmOJxzPj71fd7sIinb
         4wBQ0LH8MA1zsJvB9/15YrLiyN7ioog6y8UfvFp5SE2wjuKNyb17N3dxjttLXqKrV1Y3
         1nf8oK1Y9YiDvi9JTEvvI/TOMcQil127BYnuVZRIV7+Oy8XqDak7KHStyNxcIXlZp15k
         nZYkHPI+fuk05e43/4A5lWVRO1gHnwcU/ZgraIyRMTu6PjNyrPTP1RUY6Ebw+Vaw/Ft+
         jROQ==
X-Gm-Message-State: AOAM533+lXQCGKwn/mMTG1K+0NJce6412rmDMY7XDhJhd81aAwtyM5AM
        oMInDsPv9vMmXMbeHW9f5dYuPw==
X-Google-Smtp-Source: ABdhPJwCA1LA4NwvrUfJpr0a/T2v5OrQWQPArlZUx5JCWifS0MgN7sP370U7d1i6+cV/NQedAx0jwA==
X-Received: by 2002:ac8:7b98:: with SMTP id p24mr16682435qtu.31.1604367907411;
        Mon, 02 Nov 2020 17:45:07 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id d18sm7587566qka.41.2020.11.02.17.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 17:45:05 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Shawn Guo <shawnguo@kernel.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] clk: imx: scu: Fix compile error with module build of clk-scu.o
In-reply-to: <20201102235218.GY31601@dragon>
References: <208469.1604318525@turing-police> <6e5a8fdb-0a02-5eae-ca1f-37df8a454e34@infradead.org> <238534.1604350899@turing-police> <0b61c4f4-b389-c853-6e09-ee603455e583@infradead.org>
 <20201102235218.GY31601@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 02 Nov 2020 20:45:04 -0500
Message-ID: <253486.1604367904@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 07:52:19 +0800, Shawn Guo said:

> It's a driver problem which is being addressed by Dong's patch[1].
>
> Shawn
>
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201030153733.30160-1-aisheng.dong@nxp.com/

OK, We'll fix it that way then.
