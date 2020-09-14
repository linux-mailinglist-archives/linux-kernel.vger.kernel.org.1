Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5042686EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgINIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:12:33 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:53401 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgINILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:11:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.173])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7875E5ACBA04;
        Mon, 14 Sep 2020 10:11:13 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 14 Sep
 2020 10:11:12 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-105G006e148709d-5730-4a06-a133-7cccf876b69a,
                    33559CD024D4F69900824C14C2AC4808F9346AFD) smtp.auth=groug@kaod.org
Date:   Mon, 14 Sep 2020 10:11:11 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Jianyong Wu <jianyong.wu@arm.com>, <ericvh@gmail.com>,
        <lucho@ionkov.net>, <v9fs-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <justin.he@arm.com>
Subject: Re: [PATCH RFC 1/4] fs/9p: fix create-unlink-getattr idiom
Message-ID: <20200914101111.5b73712c@bahia.lan>
In-Reply-To: <20200914060036.GA18115@nautica>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
        <20200914033754.29188-2-jianyong.wu@arm.com>
        <20200914060036.GA18115@nautica>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 83ec8991-ebcb-4f23-9ce0-abdac57f350b
X-Ovh-Tracer-Id: 2711448452248279401
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeiiedgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepjhhushhtihhnrdhhvgesrghrmhdrtghomh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 08:00:36 +0200
Dominique Martinet <asmadeus@codewreck.org> wrote:

> Jianyong Wu wrote on Mon, Sep 14, 2020:
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> 
> Just on a note on that mail: gkurz@linux.vnet.ibm.com has no longer been
> working for a while, probably want to update to groug@kaod.org in both
> first two patches.
> Greg, sorry I had forgotten to fix Cc earlier, can you confirm?
> 

Np :) and yes I confirm that groug@kaod.org is to be used now.

14a36a435343 ("mailmap: add entry for Greg Kurz")

> 
> I'll (re)do a proper review of the first three patches again in a bit
> but iirc they looked good on paper, will resend a mail if required.
> 

