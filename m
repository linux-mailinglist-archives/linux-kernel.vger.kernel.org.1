Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548272F73CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbhAOHpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbhAOHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:45:15 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB3C061575;
        Thu, 14 Jan 2021 23:44:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 11so4965399pfu.4;
        Thu, 14 Jan 2021 23:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RSUcZOUYDHjygfK1QSy+jp5s+BrbUL+dlNwmT8GQw1w=;
        b=ZwuSSIKHJiI1sHVTdL7H8XYDfqijJG0hhQrmHfTd4uksDZccNDCrDh5bStIhowCZqb
         NKGXyPEtkYS9yM/EKrfMkARoRkxtU/aIeQ2SK70kyPJBfEp5MnVucOSEpnihvKCk/Xl3
         zp2jZzcm0/JK3oje2nd0euaEXB8Kv3Etzs9p8yYFUA0QEDx4sz1xaWzSMPIFfRjY9wZA
         M3zfEwojmDwTg/brWyXVKpbPFclkm+/hDu1hsGpz3YKTWUI6Hge1tv74UeuB7wKTn+yD
         qCFO2KXfGAXZyT5bu+TdtWh8GYSgIqL+ox0VnpIDAGv/wyh/3/uPdYo8Jzv/BHZ/dyDN
         jXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RSUcZOUYDHjygfK1QSy+jp5s+BrbUL+dlNwmT8GQw1w=;
        b=SToAUfNx0917WWp9bLw7wsi2ZgaEWPfwwvY6ydDoggPZQrsG+s+EaBCU/IA3K8m9ro
         lHgaIfHSFDZ466NngybRZkRkBQ5kYotfuKJtIs457/TVbN+slu/QCkaLWc53z23Mc8m+
         QS4M7nIG0zcknzRHzG8PtfMvRdQAeupLOulB24R9PhMr2eyDDXxJboIDdMVfQH9Sn+x+
         y2iW9UNIkv8E2Hx+C4xZVNUlJpdHRrb3u6bONJJv/gQizQa1EBgeA2sKKsQiCxkf8F0B
         mcMUM6aNnMjvf3XVnZcUzJFnhKdbGojW6gopDsXK1yCYuPUD2pYl3esv+IsdYHny5mRk
         hpog==
X-Gm-Message-State: AOAM53057w20hDsJbp/uowae3uXMXQPsX2drlaiucIlOeNV052A77X/T
        TIUOi9MF8TWEdfJff3YBS+U=
X-Google-Smtp-Source: ABdhPJwd863AHDzeAXfeQW0QLgSK+zvfW8TK+L0XEjuEWl6LDlSGvpiMNpfHbAi8oXBEA/JUxRCHEQ==
X-Received: by 2002:a63:a556:: with SMTP id r22mr11487744pgu.296.1610696674401;
        Thu, 14 Jan 2021 23:44:34 -0800 (PST)
Received: from [0.0.0.0] (n218250008152.netvigator.com. [218.250.8.152])
        by smtp.gmail.com with ESMTPSA id b18sm7381358pfi.173.2021.01.14.23.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 23:44:33 -0800 (PST)
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Perry Yuan <Perry.Yuan@dell.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <mXtNUreCVsPKizG-fnNKPId9_lQGit0S6pYEpk-aNT1hGQjVwblZDiO4E-YX3hxnrbbNN1-6hSntiv13wz66RxbhXjPJhpAVOIlZmmwUI7w=@protonmail.com>
 <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
 <ce598a92-73ef-e9a6-d772-59f5da3d251e@redhat.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <1f72244c-4510-f945-6997-baa3fcdf9d7b@gmail.com>
Date:   Fri, 15 Jan 2021 15:44:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ce598a92-73ef-e9a6-d772-59f5da3d251e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/13 2:37, Hans de Goede wrote:

> Hi,
>
> I know there already is a v3 out and I will try to get around to reviewing
> that soon, still 1 remark about the discussion surrounding v2:
>
> On 1/11/21 2:42 PM, Perry Yuan wrote:
>
> <snip>
>
>>>> *The flow is like this:
>>>> 1) User presses key. HW does stuff with this key (timeout is started)
>>>> 2) Event is emitted from FW
>>>> 3) Event received by dell-privacy
>>>> 4) KEY_MICMUTE emitted from dell-privacy
>>>> 5) Userland picks up key and modifies kcontrol for SW mute
>>>> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
>>>> 	ledtrig_audio_set(LED_AUDIO_MICMUTE,
>>>> 		rt715->micmute_led ? LED_ON :LED_OFF);
>>>> 7) If "LED" is set to on dell-privacy notifies ec,
>>>>    and timeout is cancelled,HW mic mute activated.
>>>>
>>> Please proofread the commit message again, and pay attention to capitalization
>>> and spacing.
>> I want to reformat it and move the commit info to cover letter.
> Please also put a copy of this as a comment in either the wmi or the
> acpi driver (with a comment pointing to the comment in the other) this is
> important info to have for someone reading the code and trying to understand
> how this all fits together.
>
> Regards,
>
> Hans

Hi Hans:

Agreed.

I will add this to the driver comments and explain how the acpi/wmi 
driver associated.

