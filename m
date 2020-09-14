Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A027268750
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgINIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:39:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbgINIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600072784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCnbyPYtJnKEy5YVojzV65Y7fbgg+Mn8uVF7EIN9WS0=;
        b=dXNxKjjZYWUIr8RDKC0BhXXWqnNNdQ3aRRFrvw1tYj73n/OTXzqfjoiH2wadTS3semc9fk
        Qeul6CaIG5VjoKp3h9MBMJVm30fTyCXpatdjEfju1lQhwFGIoHIHqP4jByeyThCnTCbfC3
        xhW6vgwtV+gapmTxJuLxlxj5axrMiPU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-vM1C5W6cOWCVqEV78W-Wmg-1; Mon, 14 Sep 2020 04:39:42 -0400
X-MC-Unique: vM1C5W6cOWCVqEV78W-Wmg-1
Received: by mail-ej1-f69.google.com with SMTP id qn7so7745650ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCnbyPYtJnKEy5YVojzV65Y7fbgg+Mn8uVF7EIN9WS0=;
        b=cO41Q51XclW+4ovwJEKZTDGcXMseIGdB5KzO68O8kd4qGuWOeRiObuH7sVM8TuNsx4
         MXf9CV1afV7sjHVic46Z4C4gfgtpJdEJ0glgM/mQQuFWKjTsIGeHeA6kY/7bR3FReVf7
         TlhHFQuQcz/jqGAlhnTXp3QkD2K+klTnLvuHsZlmCKKqzkc3PkTgGCYb/WVYVNJ77c+w
         YWvcufZCo+bISqqgHHJ1AiE/crbM0Ck5RJ4W3kTPlr/K/6A2ZnzZzoJN2W/runkfq90z
         TFzN/pyQAAjniEB28roiqSkDJajx8zXHgR+UY7iQMBMhzuoRqf3A0kol1KAIu62cqq8p
         G0mA==
X-Gm-Message-State: AOAM530uqrkGsNtoJYg26s9Gzm8buY8TmGF97FG96TV4WKpGCGSI4iOr
        6rLv8DaRzC7nzoT1oBYiUOZwBVrRwN73knE+da9POZ45ZJPPXEi78oI4Iq68LVhnFlehm0AHXwf
        p3Q27tI/XuYXYf7FG00ciyTyb
X-Received: by 2002:aa7:cc8d:: with SMTP id p13mr16650054edt.136.1600072781163;
        Mon, 14 Sep 2020 01:39:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZXdVARzLUw7WAq7wkDHEHhLPkouA7UD6PE5EzIGCpR1WR3HyevCJtD0Jl6rog54V8dyUT9A==
X-Received: by 2002:aa7:cc8d:: with SMTP id p13mr16650038edt.136.1600072781005;
        Mon, 14 Sep 2020 01:39:41 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id jo2sm7137504ejb.101.2020.09.14.01.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 01:39:40 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: initialize tp_nvram_state
 variable
To:     trix@redhat.com, ibm-acpi@hmh.eng.br, dvhart@infradead.org,
        andy@infradead.org, natechancellor@gmail.com,
        ndesaulniers@google.com, len.brown@intel.com
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20200913190203.22238-1-trix@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a20bfbb6-65d4-2aef-1b78-15af329d77b4@redhat.com>
Date:   Mon, 14 Sep 2020 10:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200913190203.22238-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/13/20 9:02 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this represenative problem
> thinkpad_acpi.c:2523:7: warning: Branch condition evaluates
>    to a garbage value
>                  if (!oldn->mute ||
>                      ^~~~~~~~~~~
> 
> In hotkey_kthread() mute is conditionally set by hotkey_read_nvram()
> but unconditionally checked by hotkey_compare_and_issue_event().
> So the tp_nvram_state variable s[2] needs to be initialized.
> 
> Fixes: 01e88f25985d ("ACPI: thinkpad-acpi: add CMOS NVRAM polling for hot keys (v9)")

Looking at the code I do not think this can actually happen,
this can only happen if the poll_mask == 0 the first time
through the loop so s[1] does never gets initialized and then
the second time to the loop poll_mask != 0, but if poll_mask
changes then we hit:

                 mutex_lock(&hotkey_thread_data_mutex);
                 if (was_frozen || hotkey_config_change != change_detector) {
                         /* forget old state on thaw or config change */
                         si = so;
                         t = 0;
                         change_detector = hotkey_config_change;
                 }

Where we set si = so so then this can also not happen.

I can understand the static-analyzer warning about this, and fixing
that warning is good. But I doubt that this warrants a fixes tag.

So with the Fixes tag dropped this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>


> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/platform/x86/thinkpad_acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 47925c319d7b..24da8b6872f2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -2573,7 +2573,7 @@ static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
>    */
>   static int hotkey_kthread(void *data)
>   {
> -	struct tp_nvram_state s[2];
> +	struct tp_nvram_state s[2] = { 0 };
>   	u32 poll_mask, event_mask;
>   	unsigned int si, so;
>   	unsigned long t;
> 

