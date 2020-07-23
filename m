Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A244222B0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgGWODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 10:03:20 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49867 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbgGWODU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:03:20 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6395B2002EE3C;
        Thu, 23 Jul 2020 16:03:19 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: CPU pressure despite low load average
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <d2ec0173-1754-e642-cf66-7bf1a419a36d@molgen.mpg.de>
Date:   Thu, 23 Jul 2020 16:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Johannes,


I am wondering, how PSI shows some CPU pressure (on average), while the 
load average, on a four thread system, shows a value well below four.

> $ grep -R . /proc/pressure/
> /proc/pressure/io:some avg10=0.00 avg60=0.00 avg300=0.00 total=941766173
> /proc/pressure/io:full avg10=0.00 avg60=0.00 avg300=0.00 total=818872877
> /proc/pressure/cpu:some avg10=1.24 avg60=1.05 avg300=1.18 total=7522879562
> /proc/pressure/memory:some avg10=0.00 avg60=0.00 avg300=0.00 total=62730674
> /proc/pressure/memory:full avg10=0.00 avg60=0.00 avg300=0.00 total=37176371
> $ uptime
>  15:50:39 up 8 days,  7:17,  1 user,  load average: 0,90, 0,62, 0,60


Kind regards,

Paul
