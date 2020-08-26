Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585822524D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHZAs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 20:48:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44907 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726570AbgHZAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598402937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRbJ+F9DYn9taw2FwIRj45K5IBB74D/7SXcc5vcycGY=;
        b=UBYWQN1OYQCnv0mA4+IM1z3piNyDFSpyIkDWp0UgiiI3PzpcngNZd78emoUvSRC432zN4R
        H9PVM/+Jm3N20DKmQa8wL5oH62jExPNnCnkipBl9FKrvcJOlHeCOAxwGSVclFqhIUxxxDp
        qQhPRRo1CF5tKh0sFHfuk/jGyN5VOj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-gu_RSXrGNciDV3sC1kwB_Q-1; Tue, 25 Aug 2020 20:48:55 -0400
X-MC-Unique: gu_RSXrGNciDV3sC1kwB_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3419A1DDF7;
        Wed, 26 Aug 2020 00:48:54 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76C2B100238C;
        Wed, 26 Aug 2020 00:48:53 +0000 (UTC)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwg?=
 =?UTF-8?Q?cpu_hotplug_callback?=
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "elver@google.com" <elver@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20200820032453.5222-1-qiang.zhang@windriver.com>
 <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com>
 <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>
 <87pn7ewae6.fsf@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <eedc945f-2d48-1dcf-30f3-21e2e1b094f9@redhat.com>
Date:   Tue, 25 Aug 2020 20:48:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87pn7ewae6.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 7:53 PM, Thomas Gleixner wrote:
> On Tue, Aug 25 2020 at 18:26, Waiman Long wrote:
>> On 8/25/20 12:53 AM, Zhang, Qiang wrote:
>>> When a cpu going offline, we should free objects in "percpu_obj_pool"
>>> free_objs list which corresponding to this cpu.
>> The percpu free object pool is supposed to be accessed only by that
>> particular cpu without any lock. Trying to access it from another cpu
>> can cause a race condition unless one can make sure that the offline cpu
>> won't become online in the mean time.
> It is actually safe because CPU hotplug is globally serialized and there
> is no way that an offline CPU will come back from death valley
> magically. If such a zombie ever surfaces then we have surely more
> serious problems than accessing that pool :)

Thanks for the clarification. I haven't looked into where the callback 
functions are being called so I am not 100% sure.

Cheers,
Longman

