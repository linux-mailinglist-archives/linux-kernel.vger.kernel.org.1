Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2071B1B61AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgDWROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 13:14:48 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:41889 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729674AbgDWROr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:14:47 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 13:14:46 EDT
Received: from mxback10g.mail.yandex.net (mxback10g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:171])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 2DE6C350030C;
        Thu, 23 Apr 2020 20:07:50 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10g.mail.yandex.net (mxback/Yandex) with ESMTP id CKPOo3RA33-7nHuvsHP;
        Thu, 23 Apr 2020 20:07:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1587661669;
        bh=q10Ol93uIKqGljLLQN5m691CxeTW2gdHmj35roTjhTU=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=p7MdlFTXHRMgT+FLLI6oAFz/evPhc+O5Sz7+ia10pTyRMYMv6AQ28SG7Xk4e5I664
         kGKqf3RTIpB822NMGLapGVjpFp+EC8bpp1k6bpc1zucfkbHzpqjHwfLcnuaeml88iN
         2nyqPzgOQeGHNnecrJAFN2yhgEMQx2Mye+M3Ese4=
Authentication-Results: mxback10g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-ace8bd7a4730.qloud-c.yandex.net with HTTP;
        Thu, 23 Apr 2020 20:07:49 +0300
From:   Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To:     Greg KH <greg@kroah.com>, Akira Shimahara <akira215corp@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20200423144116.GA7319@kroah.com>
References: <20200414170248.299534-1-akira215corp@gmail.com> <20200423144116.GA7319@kroah.com>
Subject: Re: [PATCH] Changes in w1_therm.c and adding w1_therm.h
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 23 Apr 2020 20:07:49 +0300
Message-Id: <307231587661588@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

23.04.2020, 17:41, "Greg KH" <greg@kroah.com>:
> You do not document any of these new sysfs files, why not?

Looks like there are bigger isues with the patch that I've missed, and if I understood correctly, Akira asked to drop this patch
