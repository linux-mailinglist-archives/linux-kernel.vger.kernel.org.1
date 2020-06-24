Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4A2074BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbgFXNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 09:41:05 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:58028 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbgFXNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rwlNhj+FV4122iecCtBkSkXK/PmNPWez1oTxJTG12WM=; b=cVLpDa3mE5IaWrzueqGGMA4Ub1
        SE4lBdrtCrJDK/lPEfTg+vq9kgQM404IanoHEuYhWy94WB4I26SsHLNYv0G79/6UAVabWFX/L9f+J
        C3J4oxkDo9AmwJ39TxvdENr47WqeAFLS5gP0J6L8XkqDM8+ubEW2JbMis7+hRVNP35dk=;
Received: from lfbn-mar-1-578-97.w109-208.abo.wanadoo.fr ([109.208.124.97] helo=[192.168.1.16])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1jo5e7-0004r3-7C; Wed, 24 Jun 2020 08:41:00 -0500
Subject: Re: [PATCH 2/3] perf symbols: Try reading the symbol table with
 libbfd
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
References: <20200624103041.825746-1-rbernon@codeweavers.com>
 <20200624103041.825746-2-rbernon@codeweavers.com>
 <20200624132545.GD2719003@krava>
From:   =?UTF-8?Q?R=c3=a9mi_Bernon?= <rbernon@codeweavers.com>
Message-ID: <8e8e5b2d-63e3-9feb-a21a-6bf355ce4013@codeweavers.com>
Date:   Wed, 24 Jun 2020 15:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624132545.GD2719003@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -25.3
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On 2020-06-24 15:25, Jiri Olsa wrote: > On Wed, Jun 24, 2020
    at 12:30:40PM +0200, Remi Bernon wrote: > > SNIP > >> + >> + symbols__insert(&dso->symbols,
    symbol); >> + } >> +#ifdef bfd_get_section >> + [...] 
 Content analysis details:   (-25.3 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  -20 USER_IN_WHITELIST      From: address is in the user's white-list
 -6.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  1.2 AWL                    AWL: Adjusted score from AWL reputation of From: address
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 15:25, Jiri Olsa wrote:
> On Wed, Jun 24, 2020 at 12:30:40PM +0200, Remi Bernon wrote:
> 
> SNIP
> 
>> +
>> +		symbols__insert(&dso->symbols, symbol);
>> +	}
>> +#ifdef bfd_get_section
>> +#undef bfd_asymbol_section
>> +#endif
>> +
>> +	symbols__fixup_end(&dso->symbols);
>> +	symbols__fixup_duplicate(&dso->symbols);
>> +	dso->adjust_symbols = 1;
>> +
>> +	err = 0;
>> +out_free:
>> +	free(symbols);
>> +out_close:
>> +	bfd_close(abfd);
>> +	return err;
>> +}
>> +#endif
>> +
>>   static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
>>   					   enum dso_binary_type type)
>>   {
>> @@ -1695,6 +1816,7 @@ int dso__load(struct dso *dso, struct map *map)
>>   		bool next_slot = false;
>>   		bool is_reg;
>>   		bool nsexit;
>> +		int bfdrc = -1;
>>   		int sirc = -1;
>>   
>>   		enum dso_binary_type symtab_type = binary_type_symtab[i];
>> @@ -1713,12 +1835,19 @@ int dso__load(struct dso *dso, struct map *map)
>>   			nsinfo__mountns_exit(&nsc);
>>   
>>   		is_reg = is_regular_file(name);
>> +#ifdef HAVE_LIBBFD_SUPPORT
>>   		if (is_reg)
>> +			bfdrc = dso__load_bfd_symbols(dso, name);
>> +#endif
> 
> so the comment says that we try bfd when the libelf fails,
> but the code seems to do the oposite.. starts with bfd
> and skip libelf if it's ok
> 
> jirka
> 

Ah, sorry I forgot to reword the commit comment to match the changes, 
thanks for noticing. It should probably be something like that:

   Trying to read symbols on non-ELF binaries with libbfd, when
   supported, makes it possible for perf to report symbols and
   annotations for Windows applications running under Wine.

As you suggested, the libbfd code now tries to detect the binary format, 
  and early rejects if ELF is detected, so it then falls back to the 
libelf code path.
-- 
Rémi Bernon <rbernon@codeweavers.com>
