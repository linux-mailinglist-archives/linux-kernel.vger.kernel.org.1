Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAD82B6C12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgKQRm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKQRmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:42:25 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB3C0613CF;
        Tue, 17 Nov 2020 09:42:25 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so16822661wrt.0;
        Tue, 17 Nov 2020 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KDI7lr583mEBfJf9QwRjZPAan5mYy9Q2XyrZiSclGR4=;
        b=cn9yXj7COy/0rOXG9U778HpQ8za2IqSo9OK7YaILh62R7kukeYpNSipaI0EvqDrSX4
         zVlAgygDbzBCGI6l0I2/o9qE4Xn1dyz0f8FZbHfoky9on5QWB52rIBnUnxf443ueMRZ+
         8mMJepDFFd5cNKxpNbosxG8oNheRhfQX7+P7eyDZQFdD9+z5tfVP80Gxn/bmdUx0KObE
         aCim7TTMw+E3oGVGoibOmmruKhQm48AFbxz6MqbcjEzt5DxOb3aV6jZzkl0p2VZm4by2
         FPCZ4AzjWa5c6SLnUznXoV0M7wHVbjQkx5Bq42iyDSVAqP7GG7Z+p4f7YVePcLsrJHB2
         wXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KDI7lr583mEBfJf9QwRjZPAan5mYy9Q2XyrZiSclGR4=;
        b=DCCYKbakt9fNG7Wq0xtpukwzRQNfkacv5YkXVKFcpZLB+IX61mJAVgPiFBpWc+xJEz
         kNh3C1XKeRWfqXFSapAwMTazcge/Od02kTbnLNebFpkH5KStHcrP7sC/igvNvPpqsI5t
         XA0qPug7wA8JMWvw/VRz4mFD81Bnu+/5XdDW1wKu47SVy8QBg4K55djxFIaRo2nq6QFm
         HUmTrH93Fc/BQQB3LggmrtO91XrR2wDbzPNfvZw0D2Mlv7oOgFJe9VQnu2xuipQhd893
         492Eo0341f4Nr87Fdhgx6pKK1f1RQ53xKZL3moo/HXbVQKHNtHKT3FlNGMoN1rkDm3Jy
         ugZw==
X-Gm-Message-State: AOAM530b2vB9SxvMFEDCgS2/sZ2vFoXSyfrGFNOi3WxXRE0dJ+Tg5yHj
        R/G9fm0n9QSTb35rvjZQZjNOfvaV8rs=
X-Google-Smtp-Source: ABdhPJwr9nFlQK6RGzbHlL+BMvLqCz0Hd1zz9xmu/gsRrg3rJdczZFszfl0ONfLpG1YgLOzfB74URw==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr614903wru.397.1605634943556;
        Tue, 17 Nov 2020 09:42:23 -0800 (PST)
Received: from [192.168.2.202] (pd9e5afac.dip0.t-ipconnect.de. [217.229.175.172])
        by smtp.gmail.com with ESMTPSA id a18sm4427352wme.18.2020.11.17.09.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 09:42:22 -0800 (PST)
Subject: Re: [PATCH 4/9] platform/surface: aggregator: Add trace points
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-5-luzmaximilian@gmail.com>
 <20201117114411.30af7078@gandalf.local.home>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <cff66ef4-9a26-69df-ee03-b6b36ab6943b@gmail.com>
Date:   Tue, 17 Nov 2020 18:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117114411.30af7078@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 5:44 PM, Steven Rostedt wrote:
> On Sun, 15 Nov 2020 20:21:38 +0100
> Maximilian Luz <luzmaximilian@gmail.com> wrote:

[...]

>>   	/*
>>   	 * Lock packet and commit with memory barrier. If this packet has
>>   	 * already been locked, it's going to be removed and completed by
>> @@ -1154,6 +1167,8 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
>>   	ktime_t next = KTIME_MAX;
>>   	bool resub = false;
>>   
>> +	trace_ssam_ptl_timeout_reap("pending", atomic_read(&ptl->pending.count));
> 
> I noticed that the only two places that use timeout_reap, both have
> "pending" as a string. Is this necessary to save? Would an enum work?

I think its probably cleaner to declare an event class for those.
Currently they are using the GENERIC_UINT_EVENT class, which I intended
as mapping with string to uint, but I'm only using that in three places,
two of which are for the timeout. So dropping the GENERIC_UINT_EVENT
class is probably the best solution(?).

[...]

>> +/**
>> + * ssam_trace_ptr_uid() - Convert the pointer to a non-pointer UID string.
>> + * @ptr: The pointer to convert.
>> + * @uid_str: A buffer of length SSAM_PTR_UID_LEN where the UID will be stored.
>> + *
>> + * Converts the given pointer into a UID string that is safe to be shared
>> + * with userspace and logs, i.e. doesn't give away the real memory location.
>> + */
>> +static inline void ssam_trace_ptr_uid(const void *ptr, char *uid_str)
>> +{
>> +	char buf[2 * sizeof(void *) + 1];
>> +
>> +	snprintf(buf, ARRAY_SIZE(buf), "%p", ptr);
>> +	memcpy(uid_str, &buf[ARRAY_SIZE(buf) - SSAM_PTR_UID_LEN],
>> +	       SSAM_PTR_UID_LEN);
> 
> Is the above snprintf() to have the ptr turn into a hash?
> 
> Otherwise, couldn't you just truncate the value of ptr?

Yes, the idea is to generate the same output for a pointer as a normal
printk message would generate, i.e. generate a (truncated) hash of the
pointer. While the trace points should be enough on their own, I prefer
to have the output lining up with the kernel log, so that we can match
packets across both if ever necessary.

> In any case, you want to make sure that ARRAY_SIZE(buf) is always bigger
> than, or equal to, SSAM_PTR_UID_LEN, and you should probably stick a:
> 
> 	BUILD_BUG_ON(ARRAY_SIZE(buf) < SSAM_PTR_UID_LEN);
> 
> in there, which would cause the build to fail if that was ever the case.

Thanks! That is a good idea.

[...]

>> +#define ssam_trace_get_command_field_u8(packet, field) \
>> +	((!packet || packet->data.len < SSH_COMMAND_MESSAGE_LENGTH(0)) \
>> +	 ? 0 : p->data.ptr[SSH_MSGOFFSET_COMMAND(field)])
> 
> I think you want the above to be:
> 
> 	? 0 : packet->data.ptr[SSH_MSGOFFSET_COMMAND(field)])
> 
> The only reason it worked, is because the caller passed in "p".

Oh, right!

>> +DECLARE_EVENT_CLASS(ssam_packet_class,
>> +	TP_PROTO(const struct ssh_packet *packet),
>> +
>> +	TP_ARGS(packet),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, state)
>> +		__array(char, uid, SSAM_PTR_UID_LEN)
>> +		__field(u8, priority)
>> +		__field(u16, length)
>> +		__field(u16, seq)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->state = READ_ONCE(packet->state);
>> +		ssam_trace_ptr_uid(packet, __entry->uid);
>> +		__entry->priority = READ_ONCE(packet->priority);
> 
> I'm curious about the need for the read once here.

I generally prefer to be explicit when accessing values that can be
changed concurrently by other parties. In the very least, this should
guarantee that the value will be read as a whole in one instruction and
the compiler does not do anything unexpected (like reading it in
multiple instructions, which could lead to invalid state or priority
values).

Arguably, the latter will very likely never happen even without the
READ_ONCE, but I prefer to be on the safe side.

> The rest seems fine.

Thanks,
Max
