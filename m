Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C892C2303
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbgKXKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:32:26 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:56424 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731415AbgKXKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:32:26 -0500
Received: from [2.127.6.98] (helo=[192.168.0.17])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1khVcU-0003bB-2Y; Tue, 24 Nov 2020 10:32:22 +0000
Subject: Re: [linux-safety] [PATCH 2/2] staging: vt6655: Correct wrappping in
 rxtx.c
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech
References: <1606132778-34209-1-git-send-email-milan.lakhani@codethink.co.uk>
 <1606132778-34209-2-git-send-email-milan.lakhani@codethink.co.uk>
 <CAKXUXMym-YfjQdDx7DcW8VHZH2bV5DbO6t0EgzmqD5hDe1AOZA@mail.gmail.com>
From:   Milan Lakhani <milan.lakhani@codethink.co.uk>
Message-ID: <e215f254-dd97-105c-fe2d-0ec786ea50ef@codethink.co.uk>
Date:   Tue, 24 Nov 2020 10:32:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMym-YfjQdDx7DcW8VHZH2bV5DbO6t0EgzmqD5hDe1AOZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 23/11/2020 13:17, Lukas Bulwahn wrote:

> On Mon, Nov 23, 2020 at 12:59 PM Milan Lakhani
> <milan.lakhani@codethink.co.uk> wrote:
>> Correct line length and alignment in rxtx.c. Reported by checkpatch.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Forest Bond <forest@alittletooquiet.net>
>> CC: linux-kernel@vger.kernel.org
>> CC: linux-safety@lists.elisa.tech
> Milan, I am wondering where you picked up this convention to add these
> Cc: and CC: tags in your patch?
>
> Is there some documentation that points out to do that? (That might
> need to be fixed...)
>
> Did you observe that on some other commits? I think these tags are
> added by some maintainers (probably tool-supported) when they pick the
> patches, not by the authors, though.

I'm using git send-email to send patches and, as described in the 
'Sending patches with git send-email' section on 
https://kernelnewbies.org/FirstKernelPatch, git-send-email automatically 
Ccs people with the the Cc and CC tags. I did see this in other commits 
too, maybe they're used by the authors to pick out the maintainers to 
send the patches to?

>
>> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
>> ---
>>   drivers/staging/vt6655/rxtx.c | 63 +++++++++++++++++++++++++++++++++----------
>>   1 file changed, 49 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
>> index 508e1bd..4073c33 100644
>> --- a/drivers/staging/vt6655/rxtx.c
>> +++ b/drivers/staging/vt6655/rxtx.c
>> @@ -492,14 +492,29 @@ s_uFillDataHead(
>>                                    pDevice->byTopCCKBasicRate,
>>                                    PK_TYPE_11B, &buf->b);
>>                  /* Get Duration and TimeStamp */
>> -               buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
>> -                                                                     wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>> -               buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, PK_TYPE_11B,
>> -                                                                      pDevice->byTopCCKBasicRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>> -               buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
>> -                                                                         wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>> -               buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
>> -                                                                        wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>> +               buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
>> +                                                                     cbFrameLength, byPktType,
>> +                                                                     wCurrentRate, bNeedAck,
>> +                                                                     uFragIdx, cbLastFragmentSize,
>> +                                                                     uMACfragNum, byFBOption));
>> +               buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
>> +                                                                     cbFrameLength, PK_TYPE_11B,
>> +                                                                     pDevice->byTopCCKBasicRate,
>> +                                                                     bNeedAck, uFragIdx,
>> +                                                                     cbLastFragmentSize,
>> +                                                                     uMACfragNum, byFBOption));
>> +               buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
>> +                                                                        cbFrameLength, byPktType,
>> +                                                                        wCurrentRate, bNeedAck,
>> +                                                                        uFragIdx,
>> +                                                                        cbLastFragmentSize,
>> +                                                                        uMACfragNum, byFBOption));
>> +               buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
>> +                                                                        cbFrameLength, byPktType,
>> +                                                                        wCurrentRate, bNeedAck,
>> +                                                                        uFragIdx,
>> +                                                                        cbLastFragmentSize,
>> +                                                                        uMACfragNum, byFBOption));
>>
> Now to this change... it seems reasonable to refactor this into a
> dedicated function or macro because this is largely "copy-and-paste"
> calls with slight variable on a single argument.
>
> How about proposing such a change instead?
Thanks, good idea, I have made a macro for it and am about to send the 
patch, it would be good to hear if it is what you were envisaging.
>>                  buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
>>                  buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
>> @@ -517,12 +532,32 @@ s_uFillDataHead(
>>                                            byPktType, &buf->a);
>>
>>                          /* Get Duration and TimeStampOff */
>> -                       buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
>> -                                                                           wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>> -                       buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
>> -                                                                              wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>> -                       buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
>> -                                                                               wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
>> +                       buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
>> +                                                                           cbFrameLength,
>> +                                                                           byPktType,
>> +                                                                           wCurrentRate, bNeedAck,
>> +                                                                           uFragIdx,
>> +                                                                           cbLastFragmentSize,
>> +                                                                           uMACfragNum,
>> +                                                                           byFBOption));
>> +                       buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice,
>> +                                                                              DATADUR_A_F0,
>> +                                                                              cbFrameLength,
>> +                                                                              byPktType,
>> +                                                                              wCurrentRate,
>> +                                                                              bNeedAck, uFragIdx,
>> +                                                                              cbLastFragmentSize,
>> +                                                                              uMACfragNum,
>> +                                                                              byFBOption));
>> +                       buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice,
>> +                                                                              DATADUR_A_F1,
>> +                                                                              cbFrameLength,
>> +                                                                              byPktType,
>> +                                                                              wCurrentRate,
>> +                                                                              bNeedAck, uFragIdx,
>> +                                                                              cbLastFragmentSize,
>> +                                                                              uMACfragNum,
>> +                                                                              byFBOption));
>>                          buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
>>                          return buf->duration;
>>                  }
>> --
>> 2.7.4
>>
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#187): https://lists.elisa.tech/g/linux-safety/message/187
>> Mute This Topic: https://lists.elisa.tech/mt/78451464/1714638
>> Group Owner: linux-safety+owner@lists.elisa.tech
>> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [lukas.bulwahn@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>
