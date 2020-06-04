Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6ED1EE63E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 16:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgFDODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 10:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgFDODk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE82BAC6C;
        Thu,  4 Jun 2020 14:03:42 +0000 (UTC)
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
 <38a2cfb9-df2a-c5cb-6797-2b96ef049c7c@oracle.com>
 <BYAPR04MB49650D649A53B89DBFE1461286890@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6c646a1e-ab40-63a1-01cb-6cc2548a3853@suse.de>
Date:   Thu, 4 Jun 2020 16:03:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49650D649A53B89DBFE1461286890@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 8:54 AM, Chaitanya Kulkarni wrote:
> On 6/3/20 11:46 PM, Dongli Zhang wrote:
>> May I get feedback for this?
>>
>> For the first time I use fcloop, I set:
>>
>> # echo "wwnn=0x3,wwpn=0x1" > /sys/class/fcloop/ctl/add_target_port
>>
>> However, I would not be able to move forward if I use "0x3" or "0x1" for nvme-fc
>> target or host further. Instead, the address and port should be
>> 0x0000000000000003 and 0x0000000000000001.
>>
>> This patch would sync the requirements of input format for nvme-fc and
>> nvme-fcloop, unless this would break existing test suite (e.g., blktest).
> If I remember correctly I don't think we have fc-loop testcases (correct
> me if I'm wrong).
> 
Well, I sent some testcases a while back (cf 'fcloop and ANA fixes').
Should I resend them?

> Not an fc expert, but having uniform format for the input make sense to
> me (unless there is an explicit reason). I'll let James have a final say.
> 

I would stick to use the full 64bit number for both wwpn and wwnn; one 
gets into too many arguments otherwise (big-endian? little-endian?).
And one could argue that '0x0000000000000001' is invalid anyway as per 
FC-FS3 a '0' in word 0 byte 0 means 'Name not present' :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
