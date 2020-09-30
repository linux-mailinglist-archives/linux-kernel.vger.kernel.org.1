Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8958427EF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbgI3Quf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Quf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:50:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B027C061755;
        Wed, 30 Sep 2020 09:50:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x5so1375839plo.6;
        Wed, 30 Sep 2020 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dKUmQimuyUfWYYZALCDrxF2spAstQLetC2caJRkHLbU=;
        b=bxfX2WXaLI7r3kKW4dqdisvqp0UQJGmnwhZC2f4dkUMbAZklfzVNyDad0QTV6VPtQw
         nkeNCSjihjo+bl3y8ubQQES4iz/ydW6rmWkLmI2us2JcBHKFWPhdMpbVCBLd+bQ+sTGq
         VB085mGZz0psCRnNnxmXepWSlYsOmBhu+Us8E/lI9v4zoYYlG1aX2T1TETopKjiUNUWF
         mg0fnrEfwJcm8p6scbpevS9Nt8EpckVvI9Mid/q0Hgj/5MncLnMMlstnncdcu6oT/qac
         YhGKuDMnNh8AH0MRDUaxqEyhjdJIW0kqgenJvj6Zy55EbI4M1xoorogtN4WbfcuQFG3H
         QiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKUmQimuyUfWYYZALCDrxF2spAstQLetC2caJRkHLbU=;
        b=ovwVLo3SrthnVf1piRI4ionxGwKy4OQSeziVd3K9M0SY7AFLStYV8pWO67nlUHMYQu
         IxCpOQ8LfFq4BYzlWdY2v+ueWuBh4AOkwM3wfmPlmshmqaNJ0qafPnc/gPSMsY+5lmxI
         6FRoWgn9CyeNlCgYEUeCQfEz9xDI3Xpt9OIZ9hSAQ0Yp+6E0sUbMmV/SxwPWcav2HFsV
         Xy0h3ZQFM1ekobemtB9ywCCEghOiravwQGyIs18hGF6Mq8Ac37498OztJxZzooPDyF7G
         NMQHQyZpufiifJBD/thN0smXxSloiByY3RJPUXDfEPlE2VpJSxUMqd2qj0rPZUlFl8Zd
         G1SA==
X-Gm-Message-State: AOAM531xKLR/HIAW62bLQmcusOtyPn5MSTl0UzbB2nGEpnICGbJev9N+
        23BOUUnSWKHH0XdhhWJBuUJ10RzpBdq/JA==
X-Google-Smtp-Source: ABdhPJxb5ZsqjleYncIIGOOsfMHsY1UWGm4TiJhG13FTOiOTB6Uwwtchv9dwWXYWqs9FOP7vH9alyA==
X-Received: by 2002:a17:90a:7bcd:: with SMTP id d13mr3525260pjl.18.1601484634451;
        Wed, 30 Sep 2020 09:50:34 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b11sm2973831pfo.15.2020.09.30.09.50.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 09:50:33 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:50:26 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com
Subject: Re: [PATCH 1/3] configs: aspeed: enable UHCI driver in defconfig
Message-ID: <20200930165025.GA25872@taoren-ubuntu-R90MNF91>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
 <20200930040823.26065-2-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930040823.26065-2-ryan_chen@aspeedtech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:08:21PM +0800, Ryan Chen wrote:
> Enable UHCI driver in aspeed_g5_defconfig.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
