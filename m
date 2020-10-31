Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15122A1B47
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 00:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgJaXo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 19:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgJaXo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 19:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604187866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVEaX24foGVerXKBE1NKNTsd3ZTUvmwtHbnXS4YnDvo=;
        b=gjhddm+kcg2jaXd3zDO36XmB0HSIdmPaDWk6jVHoIO6ip6mC6wrjxFpWEMZT+zS7H85hY2
        ySqvR7qnByY7w35rDeDBSmJgUegPnvOIMyfaELIkXza7eYFGfdr7JaLA2z1K1cfEbK1j6m
        vrP5voV4/B5Q2lWOoOQt3avRiraIYPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-ZsAqa4_9O1S35aJVlCq8cw-1; Sat, 31 Oct 2020 19:44:22 -0400
X-MC-Unique: ZsAqa4_9O1S35aJVlCq8cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E3680362B;
        Sat, 31 Oct 2020 23:44:21 +0000 (UTC)
Received: from krava (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 048FC5D993;
        Sat, 31 Oct 2020 23:44:18 +0000 (UTC)
Date:   Sun, 1 Nov 2020 00:44:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH v2 0/4] perf: Fix perf_event_attr::exclusive rotation
Message-ID: <20201031234418.GE3380099@krava>
References: <20201029162719.519685265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029162719.519685265@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:27:19PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Andi recently added exclusive event group support to tools/perf:
> 
>   https://lkml.kernel.org/r/20201014144255.22699-1-andi@firstfloor.org
> 
> and promptly found that they didn't work as specified.
> 
> (sorry for the resend, I forgot LKML the first time)

hm, it's too late for me to check ;-) but should I be able to do
this with exclusive event.. running both command at the same time:

	$ sudo ./perf stat -e cycles:e -I 1000
	#           time             counts unit events
	     1.002430650         33,946,849      cycles:e                                                    
	     2.004920725        502,399,986      cycles:e                                                      (67.57%)
	     3.007087631        859,745,048      cycles:e                                                      (50.00%)
	     4.009078254        845,860,723      cycles:e                                                      (50.00%)
	     5.011086104        838,457,275      cycles:e                                                      (50.00%)

	$ sudo ./perf stat -e cycles:e  -I 1000
	#           time             counts unit events
	     1.001665466        848,973,404      cycles:e                                                      (50.01%)
	     2.003658048        856,505,255      cycles:e                                                      (50.00%)
	     3.005658022        842,737,973      cycles:e                                                      (50.00%)
	     4.007657797        844,800,598      cycles:e                                                      (50.00%)

jirka

