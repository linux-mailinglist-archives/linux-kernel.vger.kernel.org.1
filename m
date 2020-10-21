Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A5294BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442049AbgJULsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:48:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43809 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439621AbgJULsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:48:38 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201021114834epoutp04840add8321caf31f2d8452cbb77c1690~--39MKLIe2886728867epoutp04D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:48:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201021114834epoutp04840add8321caf31f2d8452cbb77c1690~--39MKLIe2886728867epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603280914;
        bh=HkHFY6EHxZyeVuEZKZfOu4zGAnulBqBNK30grhyMG6s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=e8AUcRNNTFF8D30gCcLSnHKuK9QodLbrH18K8DXhwByrRBnC4mpVVCpXmitS7ZH6+
         kn6x1QBX1lwctjLZW6zUeDXx3hArZYSWVXCFt6286MZdoZCjLrLm4ZQXDK/nbaW5Fd
         GopYAUBe90VohVzGZzSEuSjHknMyK+bNnJNh2Dig=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20201021114833epcas2p4834f743af9bd87b9f0fe9db2d1393b59~--38h7GAg3043530435epcas2p4V;
        Wed, 21 Oct 2020 11:48:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.189]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CGTKD1bwjzMqYkV; Wed, 21 Oct
        2020 11:48:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.50.09580.010209F5; Wed, 21 Oct 2020 20:48:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20201021114830epcas2p4be321b0a680e312aac8be42359f54ab9~--35zofjP3043530435epcas2p4S;
        Wed, 21 Oct 2020 11:48:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201021114830epsmtrp1edfc72bb1fb6da94067f9c04154b1798~--35wBHYT1335113351epsmtrp1h;
        Wed, 21 Oct 2020 11:48:30 +0000 (GMT)
X-AuditID: b6c32a47-149ff7000000256c-36-5f9020106119
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.24.08745.E00209F5; Wed, 21 Oct 2020 20:48:30 +0900 (KST)
Received: from KORDD001994 (unknown [12.36.185.71]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201021114830epsmtip1d97c05b06ce24c339af903d6e39e3cd5~--35eaErm0059700597epsmtip1e;
        Wed, 21 Oct 2020 11:48:30 +0000 (GMT)
From:   =?ks_c_5601-1987?B?sejDorHi?= <changki.kim@samsung.com>
To:     "'Petr Mladek'" <pmladek@suse.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>,
        "'John Ogness'" <john.ogness@linutronix.de>
Cc:     "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Prarit Bhargava'" <prarit@redhat.com>,
        "'Mark Salyzyn'" <salyzyn@android.com>,
        "'Chunyan Zhang'" <zhang.lyra@gmail.com>,
        "'Orson Zhai'" <orsonzhai@gmail.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky.work@gmail.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20200923135617.27149-3-pmladek@suse.com>
Subject: RE: [RFC 2/2] printk: Add more information about the printk caller
Date:   Wed, 21 Oct 2020 20:48:30 +0900
Message-ID: <000001d6a7a0$18c86300$4a592900$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIUKKOc5L5O7KHwe351ByR0S6vHPwILAzL3Aha7x6KpBd/9kA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmma6AwoR4g0mv2Sy2XZnPaHF51xw2
        i+kfZjNa/H/8ldXi3Y9edot9HQ+YLH5uesho8WjCJCaLtZ8fs1ts3jSV2eJR31t2i+UPdrE7
        8Hhs272N1WPnrLvsHi37brF7vDt3jt3jxIzfLB7v911l81i/5SqLx+dNcgEcUTk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKimUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKDA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjIu7jjPXnCS
        peJ0Z3YD4xXmLkYODgkBE4nb3aZdjFwcQgI7GCXe/VvFCOF8YpS4/ucylPOZUWL9ivUsXYyc
        YB3HFh5igUjsYpTY9f4xG0hCSOAFo0TbVj0Qm03AVqK98wE7SJEIyNyXEy+BjWIWeMokcfPZ
        F3aQKk4BM4nL77pZQWxhAW+JR8sug61gEVCVeHi2D6yGV8BS4tWlSYwQtqDEyZlPwGqYBYwk
        lqyezwRhy0tsfzuHGeI8BYmfT5eBzRQRcJK4MOsVG0SNiMTszjaomgscErfXJkHYLhINH/ZC
        xYUlXh3fwg5hS0m87G+DsuslvvUvAHtZQqCHUeJv13E2iISxxKxn7YyQkFSWOHIL6jY+iY7D
        f9khwrwSHW1CEKaqRPdkfQhTWuLDDpsJjEqzkPw1C8lfs5D8NQvJ/QsYWVYxiqUWFOempxYb
        FRgjx/UmRnBK1nLfwTjj7Qe9Q4xMHIyHGCU4mJVEePNEJ8QL8aYkVlalFuXHF5XmpBYfYjQF
        BvVEZinR5HxgVsgriTc0NTIzM7A0tTA1M7JQEucNXdkXLySQnliSmp2aWpBaBNPHxMEp1cCU
        /Ojop9kN7E6GvsfZjq87NW/Zwv5XavwLuieo6mypn6HBU/9hxmXRJ8ePqq/RWsnU9WPK7T0N
        v24qxXnx8z02YZ+1IeJS36EHV3MnzQ7dJnGpN3gv88Wqgolnb0wKvhteyO8hdX6ZdFr5OrX9
        Qv6V7yJUxMzOP1/MznGp1UbugFaY2LVXYdI/nLVmPNCwDP3Ouuzfsg/6j6QdNZKS1NSfiIQX
        nmVbuGPHA/0z1w7UBD1TjzyWo/7V6sofu/niJh4Xax6IT6hZMctE/6ppgVWrSZlV+i75x4+P
        W7FYRV+8vjPqZFzOlv0N3zduv3zh0s9fuoyPpDa/+6oYuDmmpVfxtsaDOubfNSpuV7dm8ga8
        VGIpzkg01GIuKk4EAGUJ2lVSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCSnC6fwoR4gzkndS22XZnPaHF51xw2
        i+kfZjNa/H/8ldXi3Y9edot9HQ+YLH5uesho8WjCJCaLtZ8fs1ts3jSV2eJR31t2i+UPdrE7
        8Hhs272N1WPnrLvsHi37brF7vDt3jt3jxIzfLB7v911l81i/5SqLx+dNcgEcUVw2Kak5mWWp
        Rfp2CVwZF3ecZy84yVJxujO7gfEKcxcjJ4eEgInEsYWHWLoYuTiEBHYwSrx9ep4NIiEtcfzV
        bHYIW1jifssRVoiiZ4wSH5pnMIIk2ARsJdo7H7CDJEQEdjFKfF0whxnEYRZ4zSTxZHUv1NyN
        jBILfx4FW8gpYCZx+V03K4gtLOAt8WjZZRYQm0VAVeLh2T6wfbwClhKvLk1ihLAFJU7OfAJW
        wwx0bOPhbihbXmL72zlQTyhI/Hy6DGymiICTxIVZr9ggakQkZne2MU9gFJ6FZNQsJKNmIRk1
        C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwTGqpbWDcc+qD3qHGJk4GA8x
        SnAwK4nw5olOiBfiTUmsrEotyo8vKs1JLT7EKM3BoiTO+3XWwjghgfTEktTs1NSC1CKYLBMH
        p1QDk4UM67Qd2113nOfl2qxR9EI52vfbij/fZvlIHpnTKKCx14+92slO8KisesUNr1Vx257Y
        qOxaIRMdHu9/6tHLNxKTz3yRSo9epXpv91eNU2ffPDNtKV5dac4Yu+J0q73IxNTyu6sPHdy6
        LWqa+aFFaxde3rqz96zfbdfMB9I3rNbN8IqZU9T1NN6kZXdMfy/HlzK3KxsUL2hsPhIVzNu7
        OdDNQP/Jr4db65fsU7B7/+ifyhx1AU6JW3pbyleoTo16/G6aTK3cWo3esuL8PdGC+yb+qLES
        e1CVYcy92sS3jOPWEePDzflzUrY4h0ptKek9N/foFHmpjJk2RevTWzN5jS1FFHsvbPL1XXhr
        7eQtnEosxRmJhlrMRcWJAH5fk81AAwAA
X-CMS-MailID: 20201021114830epcas2p4be321b0a680e312aac8be42359f54ab9
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200923135727epcas2p4bf202e52e2ac67926a30000e98a0665b
References: <20200923135617.27149-1-pmladek@suse.com>
        <CGME20200923135727epcas2p4bf202e52e2ac67926a30000e98a0665b@epcas2p4.samsung.com>
        <20200923135617.27149-3-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static size_t info_print_caller_id(char *buf, size_t size,
> +				   const struct printk_caller *caller) {
> +	enum printk_caller_ctx ctx;
> +
> +	ctx = printk_to_caller_ctx(caller->cpu_ctx);
> +
> +	if (ctx == printk_ctx_task)
> +		return snprintf(buf, size, "T%u", caller->pid);
> +
> +	return snprintf(buf, size, "C%u",
> +printk_to_caller_cpu(caller->cpu_ctx));
> +}
> +

When I apply and test this patch, there is no change of print format
compared with previous PRINTK_CALLER.
The patch that I made is always to print the CPU ID and process name
together.

