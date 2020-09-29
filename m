Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A127BD33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgI2Gd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:33:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34596 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI2Gd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:33:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14so5113773edo.1;
        Mon, 28 Sep 2020 23:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kXPaAyGYgBinYIi+/fw8qgJiUM6BYgK83P39uCSI0g=;
        b=KHkCbj4sfqQzBlki/q+uEHYbudmAFxqFUl3LiNAsypMz9ux8Comc/sMjt7xmbS2QCs
         T/XxRslYbJoOXoSU23TDv4tO7AzIw5os2x/Y+bdHC65bf/zf937gXx2WGrFX0SllQIwn
         BBeH/e8f18a1kbx9VHX8DeDJoevMjbQ+T0mjKqZcbahOdK2VZLivckfVAA8NghDgsQVB
         jTs42XazjkRKWWGQTbjm4AoGkC8zwc1W7BCddj+DyliefQPTYJVTbkvwUkyPk9hotQcl
         mPgBme6yoKz4qVNMuXKnwmR0lBvmRmCk3eBy8oHjMOLPVgzjHrL3L4bO+xUIOAEm5wQS
         5N5A==
X-Gm-Message-State: AOAM530HpCa/101AztDY2CMzBwhZwPjg6TNEg1ennH5K9ZY+j3MP4VuB
        sJXYSLeLSrbjK6hndtX90ozKvKQ1nxqsHA==
X-Google-Smtp-Source: ABdhPJwPRrd161qMVrBFUHPLVErEU+kghhyq1fmlVEkCd6aDH35ZF/6vxzFG0n5JoyMktfI+wvLm3Q==
X-Received: by 2002:a05:6402:1710:: with SMTP id y16mr1629702edu.197.1601361205726;
        Mon, 28 Sep 2020 23:33:25 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id q13sm4841614edr.27.2020.09.28.23.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 23:33:25 -0700 (PDT)
Subject: Re: Patch "ata: sata_mv, avoid trigerrable BUG_ON" has been added to
 the 4.4-stable tree
To:     Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org
References: <20200927181119.5ACB623A33@mail.kernel.org>
 <20200928123057.GA1116804@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <167f8a53-6b68-05b8-a632-34df046a0376@kernel.org>
Date:   Tue, 29 Sep 2020 08:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928123057.GA1116804@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 09. 20, 14:30, Greg KH wrote:
>> commit 4b308d858a1a34dae1e38948f2c0497161d9ddd8
>> Author: Jiri Slaby <jslaby@suse.cz>
>> Date:   Thu Oct 31 10:59:46 2019 +0100
>>
>>     ata: sata_mv, avoid trigerrable BUG_ON
>>     
>>     [ Upstream commit e9f691d899188679746eeb96e6cb520459eda9b4 ]
>>     
>>     There are several reports that the BUG_ON on unsupported command in
>>     mv_qc_prep can be triggered under some circumstances:
>>     https://bugzilla.suse.com/show_bug.cgi?id=1110252
>>     https://serverfault.com/questions/888897/raid-problems-after-power-outage
>>     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
>>     https://bugs.centos.org/view.php?id=14998
>>     
>>     Let sata_mv handle the failure gracefully: warn about that incl. the
>>     failed command number and return an AC_ERR_INVALID error. We can do that
>>     now thanks to the previous patch.
>>     
>>     Remove also the long-standing FIXME.
>>     
>>     [v2] use %.2x as commands are defined as hexa.
>>     
>>     Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>>     Cc: Jens Axboe <axboe@kernel.dk>
>>     Cc: linux-ide@vger.kernel.org
>>     Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index 729f26322095e..c24bbdb3f76c8 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -2113,12 +2113,10 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
>>  		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
>>  		 * of which are defined/used by Linux.  If we get here, this
>>  		 * driver needs work.
>> -		 *
>> -		 * FIXME: modify libata to give qc_prep a return value and
>> -		 * return error here.
>>  		 */
>> -		BUG_ON(tf->command);
>> -		break;
>> +		ata_port_err(ap, "%s: unsupported command: %.2x\n", __func__,
>> +				tf->command);
>> +		return AC_ERR_INVALID;
>>  	}
>>  	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
>>  	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);
> 
> This causes a build warning as you can not return a value for a void
> function :(

Sure, you need the patch before, i.e. e9f691d899^:
commit 95364f36701e62dd50eee91e1303187fd1a9f567
Author: Jiri Slaby <jirislaby@kernel.org>
Date:   Thu Oct 31 10:59:45 2019 +0100

    ata: make qc_prep return ata_completion_errors



And that needs one more patch e9f691d899^^:

commit 25937580a5065d6fbd92d9c8ebd47145ad80052e
Author: Jiri Slaby <jirislaby@kernel.org>
Date:   Thu Oct 31 10:59:44 2019 +0100

    ata: define AC_ERR_OK

thanks,
-- 
js
suse labs
