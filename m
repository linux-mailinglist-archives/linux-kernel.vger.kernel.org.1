Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B459D201B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbgFSTaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbgFSTaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:09 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E0AC06174E;
        Fri, 19 Jun 2020 12:30:09 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 90A6823B;
        Fri, 19 Jun 2020 19:30:08 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:30:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     <harryxiyou@gmail.com>, <alex.shi@linux.alibaba.com>,
        <mchehab+huawei@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs/zh_CN: update sysfs.txt about show() usage
Message-ID: <20200619133007.37bf1b90@lwn.net>
In-Reply-To: <20200610025333.84010-1-chenzhou10@huawei.com>
References: <20200610025333.84010-1-chenzhou10@huawei.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 10:53:33 +0800
Chen Zhou <chenzhou10@huawei.com> wrote:

> Update the show() usage according to the English version.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  Documentation/translations/zh_CN/filesystems/sysfs.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

jon
