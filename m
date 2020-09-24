Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C95276CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgIXJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:04:31 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:39045 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgIXJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:04:30 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 05:04:29 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.237])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id E56615E550ED;
        Thu, 24 Sep 2020 10:56:19 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 24 Sep
 2020 10:56:19 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-106R006c5bf5594-637d-4083-858d-063c7491bba4,
                    85AEC8A2294FDACAA0F214F2A1981C2CEEF9973D) smtp.auth=groug@kaod.org
Date:   Thu, 24 Sep 2020 10:56:18 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
CC:     Dominique Martinet <asmadeus@codewreck.org>,
        "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "qemu_oss@crudebyte.com" <qemu_oss@crudebyte.com>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>
Subject: Re: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Message-ID: <20200924105618.556b9a8d@bahia.lan>
In-Reply-To: <HE1PR0802MB25556D1AAF1336F4EE3CA8DBF4390@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
        <20200923141146.90046-5-jianyong.wu@arm.com>
        <20200923144953.GA1685@nautica>
        <HE1PR0802MB25556D1AAF1336F4EE3CA8DBF4390@HE1PR0802MB2555.eurprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: b77c1de3-76da-4996-88e1-519bcc2401cd
X-Ovh-Tracer-Id: 6859826660615493996
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueffteeuffekveffhfffueejkeeitdfgjedvtdelgfettdffgfffieeijefftdevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplfhushhtihhnrdfjvgesrghrmhdrtghomh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 08:38:01 +0000
Jianyong Wu <Jianyong.Wu@arm.com> wrote:

> > Given the other thread, what did you test this with?  
> Er, I just use Greg's qemu of https://github.com/gkurz/qemu.git: 9p-attr-fixes. I should have referenced it in commit message.

... which is a pretty old QEMU version BTW.

https://github.com/gkurz/qemu/blob/9p-attr-fixes/VERSION

2.6.50 aka 2.7 development tree

As said by Christian in some other mail, if someone wants these fixes to be
effective when using QEMU, they should maybe invest time to rebase against
the current development branch. I personally don't have time to do that but
I'm available to answer questions if needed.

Cheers,

--
Greg
