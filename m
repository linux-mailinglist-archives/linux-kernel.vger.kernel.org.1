Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB742FFD60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAVH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:28:04 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29056 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbhAVH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:27:48 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210122072704epoutp016925ff72230f65dab5360b24d883dba7~cfTLx5zwO0608306083epoutp01t
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:27:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210122072704epoutp016925ff72230f65dab5360b24d883dba7~cfTLx5zwO0608306083epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611300424;
        bh=rRKA82/8D1nqq9PmfoTE6xnuxlEuH7qiqplBHYpduts=;
        h=Date:From:To:Cc:Subject:Reply-To:In-Reply-To:References:From;
        b=EkLuvthh3rbn35PKSSdrJFBN80ueG5qzV9T65MRQYSi806fVOqPL/QP91/Mz7GEsy
         w+Knunsl2SmNf/GxlVm9tMDybM0anfDEdzs2GTEby4Dn1I/VuBD0wmm67v8bLieYB7
         2nthNWJUDLwI/WtZSwM92duckFfSQ/IiqDrdjwmM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210122072704epcas2p10a96317a83563d77c4d84952af4226ac~cfTLaOYeg1701917019epcas2p1A;
        Fri, 22 Jan 2021 07:27:04 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DMW6Z43qgz4x9Q1; Fri, 22 Jan
        2021 07:27:02 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.80.52511.44E7A006; Fri, 22 Jan 2021 16:27:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210122072700epcas2p37a79e9fb536c69b3f2ed135f39e08749~cfTH8Kvtp1917319173epcas2p37;
        Fri, 22 Jan 2021 07:27:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210122072700epsmtrp146937bead56b30d4f6e768e36f97590a~cfTH7Irje0115301153epsmtrp15;
        Fri, 22 Jan 2021 07:27:00 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-2d-600a7e44911c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.10.13470.44E7A006; Fri, 22 Jan 2021 16:27:00 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210122072700epsmtip2a1b108374f4bd34df6dd6434a0389bbb~cfTHwxfTN0187401874epsmtip2j;
        Fri, 22 Jan 2021 07:27:00 +0000 (GMT)
Date:   Fri, 22 Jan 2021 16:15:40 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
Message-ID: <20210122071540.GB121941@ubuntu>
Reply-To: eg Kroah-Hartman <gregkh@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20210122064125.GA121941@ubuntu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmha5LHVeCwbMryhbH2p6wW9xZMI3J
        onnxejaLy7vmsFksWtbKbLFqwQF2i7VNs9gc2D0u9/UyeWxa1cnmsX/uGnaPvi2rGD227P/M
        6PF5k1wAW1SOTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5b
        Zg7QLUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAkPDAr3ixNzi0rx0veT8XCtD
        AwMjU6DKhJyMA8vvsBTM5qpYNnUZcwPjPo4uRk4OCQETifs39jJ3MXJxCAnsYJR4POckK0hC
        SOATo8S6/nCIxDdGiVNHZjF1MXKAdZybrAIR38socezKJjYI5wmjxNapx8G6WQRUJbqa5zKC
        2GwCWhL3fpxgBrFFBKok9n+axgZiMwucZJTY8zUdxBYWcJeYePsuC4jNK6AjsW7dBXaIK8wl
        /i2bDxUXlDg58wmYzSmgK/Fv4yxmkINEBVQkXh2sB7lBQmAih0Tb94vsEK+5SEx8txTKFpZ4
        dXwLlC0l8bK/jR3imXKJRfPtIHo7GCXWfDrLCFFjLDHrWTsjxJ0ZEhOfTYaqV5Y4cosFIswn
        0XH4L1SYV6KjTQiiU1li+uUJrBC2pMTB1+eYIWwPiW+v/0GDqoFR4t2OmcwTGBVmIflsFpJt
        ELaOxILdn9hmAa1gFpCWWP6PA8LUlFi/S38BI+sqRrHUguLc9NRiowIT5GjfxAhOsVoeOxhn
        v/2gd4iRiYPxEKMEB7OSCO8jS44EId6UxMqq1KL8+KLSnNTiQ4ymwCibyCwlmpwPTPJ5JfGG
        pkZmZgaWphamZkYWSuK8RQYP4oUE0hNLUrNTUwtSi2D6mDg4pRqYGv3lT7CGeW3xbTrwtqSn
        iMdF2GhrSyJfhsLNv8eXrgn5z5h0OHxHes+9hiS3nbur/CKtf6/T95wmxHpb9i/79I26m66f
        DfM10S/P5vkqfIfZPbk+crbHpm3X4x1Vans4pndPTrpyekWwY3aJqNKOPXnpwQaROc3HFzbM
        PPz89XznR1EBf9rDLpX9Sl/CKhBXWZ9tEhbH2OfAJPjdrEPgcQrH+ch6lYCXRsXrdsr1J8e3
        CkZtvTNTOXQyU8tpTudEndm7M7pZGjlq7SZ+crJWLk2f91Vt7TzP54ujT8rteWE+tcCJvztr
        daF7xD6/lGf95vGaPkoXdvgfWf5Maw7rkdx7+/7+X/962n6xeUosxRmJhlrMRcWJAAOB75M6
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvK5LHVeCwY8WPotjbU/YLe4smMZk
        0bx4PZvF5V1z2CwWLWtltli14AC7xdqmWWwO7B6X+3qZPDat6mTz2D93DbtH35ZVjB5b9n9m
        9Pi8SS6ALYrLJiU1J7MstUjfLoEr4/T63WwFt9krTh//ztLAOJ2ti5GDQ0LAROLcZJUuRi4O
        IYHdjBIT+28xdTFyAsUlJZbOvcEOYQtL3G85wgpR9IhR4vaTpawgCRYBVYmu5rmMIDabgJbE
        vR8nmEFsEYEaieauNSwgDcwCpxkllhydDpYQFnCXmHj7LguIzSugI7Fu3QWwDUIC5hL/ls1n
        gdjQwChx5N1VqCJBiZMzn4DZzEAbbvx7yQRyNrOAtMTyfxwgYU4BXYl/G2cxg4RFBVQkXh2s
        n8AoNAtJ8ywkzbMQmhcwMq9ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOEi3NHYzb
        V33QO8TIxMF4iFGCg1lJhPeRJUeCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUwn7RifPVZJ+Cr+gZlHxOB746694kdL+r/x7lqxcdPVHQ++5V+bGcVw
        4rvU/dDJn6Vkj3xL9vKwmzBxnRp/dYS3zNmXHj/0Kza4H3rY2aQnF7tmhmVYQ1DVxXa2+uiW
        VDGdjaYM7LsZFJ+dM3zG9NF392GeuI3Tz3wXjam5quRSp2obX1q/1Pq2f2tN0oHGCfrumi9r
        7iwzeDQ38WHGwuc5pnb6X2zENPf+uG93sdrwEkO0kv1lg/LDHw8Utp1KZjd2dTd+oN76/33Y
        3XDTvV52h1zZlwu9+qIYOUP4flfcnSvCr24k3N33xNDynPki83eSGUkKZv+4Cupll9+Su6HK
        GsrktnWi5zYXvrg2ZSWW4oxEQy3mouJEACp2MQQBAwAA
X-CMS-MailID: 20210122072700epcas2p37a79e9fb536c69b3f2ed135f39e08749
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_2224e_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210122065248epcas2p19a972d3a385b91d6e05a16f2ef7b0dd6
References: <CGME20210122065248epcas2p19a972d3a385b91d6e05a16f2ef7b0dd6@epcas2p1.samsung.com>
        <20210122064125.GA121941@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_2224e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Jan 22, 2021 03:32, Wesley cheng wrote:
> Hi Daehwan,
> 
> If this is an unexpected event where userspace initiates the UDC bind
> sequence, then after the above sequence occurs, the DWC3 device should
> still be able to re-enter runtime suspend after the autosuspend timer
> expires.  Since the cable is disconnected, the dwc->connected flag would
> still be false.  Is this not happening in your situation?
> 
> I'm just trying to understand what issue you're seeing other than the
> momentary transition from runtime suspend (due to cable disconnect)
> -->runtime resume (due to unexpected UDC bind) --> runtime  suspend (due
> to nothing connected).
> 
> Thanks
> Wesley cheng

Hi Wesley,

I don't know why but DWC3 device is not re-entering runtime-suspend in
my situation. I'm still debugging it.
Even if DWC3 re-enter runtime-suspend but it doesn't mean stopping gadget.
Are you stopping gadget manually in this case?

Best Regards,
Jung Daehwan

------WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_2224e_
Content-Type: text/plain; charset="utf-8"


------WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_2224e_--
