Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582102FF234
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbhAURmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:42:51 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:63634 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388835AbhAURm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1611250895; x=1613842895;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9QcfXGfK2f5YxK/K7zmQNjegnxFFDNUBiNhCddIYLuk=;
        b=Caa8XaLUT4A2bPMzDwAMHWyfK9iJ65CCxYCuKxgTO/qie2q1zE17leKpofms0JtS
        1ryRWZSajhqP2lG8xiknYB0Y1iNNFIM0VjBDMpdudJrERSbVzukGJWMMM8ZBAsKy
        VU8TAx7bH21wUTYpdHWuVyc86N3nUJm6p8+cHPRfB+8=;
X-AuditID: c39127d2-0d3b770000001c86-b6-6009bccfd4d7
Received: from Florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5A.FA.07302.FCCB9006; Thu, 21 Jan 2021 18:41:35 +0100 (CET)
Received: from [172.16.21.73] (172.16.0.116) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 21 Jan
 2021 18:41:35 +0100
Subject: Re: restore splice and sendfile support on kernfs
To:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     Siddharth Gupta <sidgup@codeaurora.org>,
        <linux-kernel@vger.kernel.org>
References: <20210120204631.274206-1-hch@lst.de>
From:   Robert Karszniewicz <r.karszniewicz@phytec.de>
Message-ID: <5a13228c-6003-2499-a987-23d39f1926cf@phytec.de>
Date:   Thu, 21 Jan 2021 18:41:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210120204631.274206-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.0.116]
X-ClientProxiedBy: Florix.phytec.de (172.16.0.118) To Florix.phytec.de
 (172.16.0.118)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWyRoChTPf8Hs4Eg6UbTC2aF69ns1i5+iiT
        xeVdc9gs7r17z2rxa/lRRgdWj8t9vUwem1Z1snnsn7uG3WP3zQY2j8+b5AJYo7hsUlJzMstS
        i/TtErgy2junMBf8ZK242v+HtYHxJUsXIyeHhICJxM1lS9i7GLk4hASWMUnM39LKDOHcZ5Q4
        /ewjG0iVsICVxKE9m4BsDg4RgQKJ01P9QcLMAt4SD48sYwWxhQQMJC613mcGsdmAhu5uvgVm
        8wrYSJz7uBFsDIuAqsTkSc1gcVGBCInWvk6oGkGJkzOfsICM5xQwlHi2RxvEZBbQlFi/Sx9i
        k7jErSfzmSBseYntb+cwQ2xVlTjd9poJ4hUFibm/JzJD2OES837PYp/AKDwLyYJZCFNnIZk6
        C8nUBYwsqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzECo+TwRPVLOxj75ngcYmTiYDzEKMHBrCTC
        +8iSI0GINyWxsiq1KD++qDQntfgQozQHi5I47wbekjAhgfTEktTs1NSC1CKYLBMHp1QDY/mc
        +sIHMrumTudpe5V67dFiu0r1nNJbvy4fE/msPuO/od/xCzerFcvLG9pXeLd86L2aZ7sghENW
        7vXmnHu8juvTb3GKfvSbIF35ojuzpF3s5rSpR480LZ4tteRu7uK7J4OaTk2dz7Nkk5jAWREf
        c//QF9VvrmSZp35asY7n3UQ9VcbL5tt36yixFGckGmoxFxUnAgDCgALjgAIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 9:46 PM, Christoph Hellwig wrote:
> Hi Greg and Tejun,
> 
> this fixes a regression in Linux 5.10 that stopped sendfile and splice
> from working on kernfs/sysfs files.
> 
> Diffstt:
>  file.c |   65 ++++++++++++++++++++++++-----------------------------------------
>  1 file changed, 24 insertions(+), 41 deletions(-)
> 

Tested-by: Robert Karszniewicz <r.karszniewicz@phytec.de>

Confirm that it fixes firmwared for me.

Also, I am 100% sure that the commit that actually breaks firmwared for me is
4d03e3cc5982 ("fs: don't allow kernel reads and writes without iter ops")
which is one commit right before
36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
. I just verified it again.

Thank you,
Robert
