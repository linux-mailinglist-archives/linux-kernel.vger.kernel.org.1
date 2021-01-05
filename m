Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A678A2EB09F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbhAEQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:52:13 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:2345 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbhAEQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1609865532; x=1641401532;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OB4QxC/gO4zMAIb2hjh/npymPegud6p74FvO1Z0m3Is=;
  b=T+QUNk7pV4ry7GhFUbFp10sK+dztazPDDJfjJJjgRBgTwtffEouu5PPU
   CliQCKcvjIgvzHwTje7dyfQ3/sH9HgwV4rsLshfjiRLiSkAP5ghpgxjF6
   19C61QF18KvAciqjvHiT9miOgjNMKZJRA37LYNvV/a0Bb2M9NJWp3ZeP9
   0=;
X-IronPort-AV: E=Sophos;i="5.78,477,1599523200"; 
   d="scan'208";a="108404997"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7f73527.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Jan 2021 16:51:31 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7f73527.us-east-1.amazon.com (Postfix) with ESMTPS id C53D1ACF1A;
        Tue,  5 Jan 2021 16:51:30 +0000 (UTC)
Received: from EX13D12UWC002.ant.amazon.com (10.43.162.253) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 Jan 2021 16:51:30 +0000
Received: from [10.95.184.140] (10.43.161.179) by EX13D12UWC002.ant.amazon.com
 (10.43.162.253) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 Jan
 2021 16:51:29 +0000
Subject: Re: [PATCH v2] scripts/gdb: fix list_for_each
From:   George Prekas <prekageo@amazon.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <4ae23bb1-c333-f669-da2d-fa35c4f49018@amazon.com>
Message-ID: <04baeb3e-4b46-ae3a-b4e1-4663d1510b05@amazon.com>
Date:   Tue, 5 Jan 2021 10:51:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4ae23bb1-c333-f669-da2d-fa35c4f49018@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D19UWA001.ant.amazon.com (10.43.160.169) To
 EX13D12UWC002.ant.amazon.com (10.43.162.253)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2020 9:20 AM, George Prekas wrote:
> If the list is uninitialized (next pointer is NULL), list_for_each gets
> stuck in an infinite loop. Print a message and treat list as empty.
>
> Signed-off-by: George Prekas <prekageo@amazon.com>
> ---
>  scripts/gdb/linux/lists.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
> index c487ddf09d38..bae4d70b7eae 100644
> --- a/scripts/gdb/linux/lists.py
> +++ b/scripts/gdb/linux/lists.py
> @@ -27,6 +27,11 @@ def list_for_each(head):
>          raise TypeError("Must be struct list_head not {}"
>                             .format(head.type))
>
> +    if head['next'] == 0:
> +        gdb.write("list_for_each: Uninitialized list '{}' treated as 
> empty\n"
> +                     .format(head.address))
> +        return
> +
>      node = head['next'].dereference()
>      while node.address != head.address:
>          yield node.address

Happy New Year!

Any updates on this?

Thanks,
George

