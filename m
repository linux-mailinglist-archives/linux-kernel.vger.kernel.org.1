Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A3C286D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgJHDeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgJHDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:34:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB3C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:34:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e22so5987335ejr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sul8Dp6ULzHs9uhLFcHqUMOwUDviuVpIZeNf4gu07RM=;
        b=s9LeSxb+yukgTwhh48lz7LLaH8sjpqEtMl/ZhHbfSHZFph5k0mecRe8JXAtBmGVdC5
         Oqzx+0eL9TYzThrCmFUNvJmF0m9yFkxbDVGJ9y9cwo6sUBPv9DXGf5aNPdN8x/0okGZR
         kkjKB+0f6/1iZnLCwcpEJBkTs3DFeN1VhpeF20w6kCFD+zKT/qHBWrp+KxzQsp/BnlHb
         68t6OjlVLkXtxGe4rmBiVm+iF4W+xYRXDFbsztAeeUhtQO+BYiVGTge4LPuLTK8bTzTA
         b4lwK8Ek/m2qN3nD9YUuZmGb5Yjcsq1ItV0chMExgs5c+GlgMnft5kh+GwZxxCTuhW+R
         mJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sul8Dp6ULzHs9uhLFcHqUMOwUDviuVpIZeNf4gu07RM=;
        b=J+ev2YPqYMPvCna16ncoUDeR36Us7sm5W7q4bQ48+Da2KJEfgMJuR21MXD72hUZTFS
         vf28HbEWjd7040kzsQlS6G99ObrGbmdFm6HUckMV4HuWqTb8z+JoOfzBsFpc+wI5I9qG
         Qy7HyuggPw3IZzinjsSgE9J5v3d3rtlQoX0LgxnegMmWke1cDJjuCVPpsCjrUNYbj5vf
         CqfFMjhtr7oIaxNc8RphwEdWXC+ezreN/k0RAMCYhb2wuSwbI9aj6W0QOMf8BTfhktKR
         tCzMQkV2PS2+0OSIexSLkmGKI8lRvx/TLjIzrUvvrtjrPcDXDDZhzgTLeFP6DdHzJzIt
         IGMA==
X-Gm-Message-State: AOAM533JVEST4LLWXERdMW/kc4ph2F8euXnlsOvlEh4F7Dkg0jU5z3tf
        k2V44zL+jhHUrwNj5IGUmmOLMlLJCfg=
X-Google-Smtp-Source: ABdhPJy9w4ZSEowgHQP1wPgLvIhRxDiGd2m44jX2uxNSIeE8bY6M0WwcDqKhRpONgt0MUoh/tBM83w==
X-Received: by 2002:a17:906:7f8c:: with SMTP id f12mr6796716ejr.8.1602128058943;
        Wed, 07 Oct 2020 20:34:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id jr9sm2945922ejb.87.2020.10.07.20.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Oct 2020 20:34:17 -0700 (PDT)
Date:   Thu, 8 Oct 2020 03:34:16 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ftrace: define seq_file only for FMODE_READ
Message-ID: <20201008033416.anmamvegf2g2zfwv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
 <20200831031104.23322-2-richard.weiyang@linux.alibaba.com>
 <20201006103638.153e39d3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006103638.153e39d3@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:36:38AM -0400, Steven Rostedt wrote:
>On Mon, 31 Aug 2020 11:10:59 +0800
>Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>
>> The purpose of the operation is to get ftrace_iterator, which is embedded
>> in file or seq_file for FMODE_WRITE/FMODE_READ respectively. Since we
>> don't have a seq_file for FMODE_WRITE case, it is meaningless to cast
>> file->private_data to seq_file.
>> 
>> Let's move the definition when there is a valid seq_file.
>
>I didn't pull in this patch because I find the original more expressive,
>and there's really no benefit in changing it.
>

Got it, thanks

>-- Steve
>
>
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  kernel/trace/ftrace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index edc233122598..12cb535769bc 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -5558,7 +5558,6 @@ static void __init set_ftrace_early_filters(void)
>>  
>>  int ftrace_regex_release(struct inode *inode, struct file *file)
>>  {
>> -	struct seq_file *m = (struct seq_file *)file->private_data;
>>  	struct ftrace_iterator *iter;
>>  	struct ftrace_hash **orig_hash;
>>  	struct trace_parser *parser;
>> @@ -5566,6 +5565,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
>>  	int ret;
>>  
>>  	if (file->f_mode & FMODE_READ) {
>> +		struct seq_file *m = file->private_data;
>>  		iter = m->private;
>>  		seq_release(inode, file);
>>  	} else

-- 
Wei Yang
Help you, Help me
