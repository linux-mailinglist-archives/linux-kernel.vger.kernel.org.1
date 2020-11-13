Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CAB2B1BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgKMNTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgKMNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605273582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnoPLyOX/h7MCaXrXZHC7dyhMFH1QSsetRdYcwZkmYM=;
        b=dMiEW8Z2FbjSYgf8eZr+9kCUiDDd16b6n1czQZINlWeZsiYi1XFnHXjAKL4Oq/30JvDyBy
        WlvvflUBt8cDvZFRy6mALAXcH8c4mKhiMtHLWub/pnqESueO8TfQ0H+r7GwKo1EpXZFu4B
        AHxOmYfHorQN35SGeoFqbHX11Yzv1tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-nfKeUujtOrapViKJpY9fCw-1; Fri, 13 Nov 2020 08:19:40 -0500
X-MC-Unique: nfKeUujtOrapViKJpY9fCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E847564157;
        Fri, 13 Nov 2020 13:19:38 +0000 (UTC)
Received: from [10.36.113.83] (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CDFF19930;
        Fri, 13 Nov 2020 13:19:33 +0000 (UTC)
Subject: Re: ERROR: modpost: "mac_pton" undefined!
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <202011131937.7Fy1Jnv1-lkp@intel.com>
 <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
 <CAHp75Ve14rt_xDS40-bE2PGzo9JGKzqU0nPz_kbwngkn-upGVw@mail.gmail.com>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <87d01fe1-1746-d31b-80aa-6adf286884c8@redhat.com>
Date:   Fri, 13 Nov 2020 14:19:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve14rt_xDS40-bE2PGzo9JGKzqU0nPz_kbwngkn-upGVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2020 14:12, Andy Shevchenko wrote:
> On Fri, Nov 13, 2020 at 2:42 PM Laurent Vivier <lvivier@redhat.com> wrote:
> 
> ...
> 
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>>>> ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
>>
>> I think something like this might fix the problem.
> 
> ...
> 
>> +       select NET
>>         default n
> 
> You may also drop 'default n' :-)
> 
> But what I want to say is that API is under NET_UTILS, I dunno if the
> driver requires full NET to be selected. And IIRC NET_UTILS is
> selected by NET.

I think GENERIC_NET_UTILS might be enough.

The problem I have for the moment is to find or1k-linux-gcc for my Fedora 33...

Thanks,
Laurent

