Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914C6283F86
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgJETXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgJETXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:23:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F388C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=KlYHzF1kfXAq/Cc2HDvXD5GjEU5+8TAzq4Axo6GqLTA=; b=rmNS8zN8e8/KXI5/TmQ6KZJ3e0
        rvNcWTBFlBIaXY3V6Q3RcmXuOgQJyK8cqaUkznGXMXMTzZ0fTE9PO8NfM5iXttX7CCUQminjhOcni
        JubHMqbpQjpBWDbvQ9s2clke7n7FNBv89u+22hAbnxHlhLorXMuc/Ww46Kd1NxisdolK9hRwu7FQI
        XDWIWCAZNMrc6TlGtSHyQ4UuFmAiDdWpYGSRcm976LJAZfCPPhPF8vOQehRBmsdy4PsOH/RLh9Aa7
        CPsuby1fnVJ2IyF3I23qpDao+3VrE0hjyEwxGDZ/nS0zjlaCiQoTQwY2FltqtEwCqS3wVy8PmQdAA
        7tzfcM1w==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPW5A-0007r6-Lf; Mon, 05 Oct 2020 19:23:37 +0000
Subject: Re: [PATCH] sound: sparc: dbri: fix repeated word 'the'
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
References: <20201005191234.12715-1-rdunlap@infradead.org>
 <714e5d92d8b9f3ba365ec0cabf1406ea1a847d69.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8488a43-4f89-604a-0f25-c906d138ba82@infradead.org>
Date:   Mon, 5 Oct 2020 12:23:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <714e5d92d8b9f3ba365ec0cabf1406ea1a847d69.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 12:21 PM, Joe Perches wrote:
> On Mon, 2020-10-05 at 12:12 -0700, Randy Dunlap wrote:
>> Drop the duplicated word "the".
> []
>> --- lnx-59-rc8.orig/sound/sparc/dbri.c
>> +++ lnx-59-rc8/sound/sparc/dbri.c
>> @@ -620,7 +620,7 @@ A circular command buffer is used here.
>>  while another can be executed. The scheme works by adding two WAIT commands
>>  after each sent batch of commands. When the next batch is prepared it is
>>  added after the WAIT commands then the WAITs are replaced with single JUMP
>> -command to the new batch. The the DBRI is forced to reread the last WAIT
>> +command to the new batch. The DBRI is forced to reread the last WAIT
> 
> Maybe Then the?

Sure, I'm OK with that.

>>  command (replaced by the JUMP by then). If the DBRI is still executing
>>  previous commands the request to reread the WAIT command is ignored.

thanks.
-- 
~Randy

