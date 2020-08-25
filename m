Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0306252398
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHYW0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 18:26:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24260 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbgHYW0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598394395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVAr3vBma9VREIJq5jB5vDkVx59biKq2HSna+Tb5Zxw=;
        b=KrCG4gbw5dFgbwg84+Q9HM5ieakF5DpZBPNrJlrD2DIFob/3Qv4wJpRmmbEm/LMEU5dLm6
        Ok3oUzuXLsJ2Ss2DtVt1bw0/GfLChc+BRnKx8iogJsaX22rHxj7d1oFr1SLyWMiHhMMLnN
        SGtghwMNOWrsEn8V4pldG/eYMdTdZic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-OoimmDYNPFaOcnn8Nw4DFg-1; Tue, 25 Aug 2020 18:26:31 -0400
X-MC-Unique: OoimmDYNPFaOcnn8Nw4DFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C048030B4;
        Tue, 25 Aug 2020 22:26:30 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34CFE5D9D3;
        Tue, 25 Aug 2020 22:26:30 +0000 (UTC)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwg?=
 =?UTF-8?Q?cpu_hotplug_callback?=
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "elver@google.com" <elver@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20200820032453.5222-1-qiang.zhang@windriver.com>
 <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>
Date:   Tue, 25 Aug 2020 18:26:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 12:53 AM, Zhang, Qiang wrote:
> ________________________________________
> 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 qiang.zhang@windriver.com <qiang.zhang@windriver.com>
> 发送时间: 2020年8月20日 11:24
> 收件人: tglx@linutronix.de; elver@google.com; longman@redhat.com
> 抄送: linux-kernel@vger.kernel.org
> 主题: [PATCH] debugobjects: install cpu hotplug callback
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> When a cpu going offline, we should free objects in "percpu_obj_pool"
> free_objs list which corresponding to this cpu.

The percpu free object pool is supposed to be accessed only by that 
particular cpu without any lock. Trying to access it from another cpu 
can cause a race condition unless one can make sure that the offline cpu 
won't become online in the mean time. There shouldn't be too many free 
objects in the percpu pool. Is it worth the effort to free them?

Cheers,
Longman

