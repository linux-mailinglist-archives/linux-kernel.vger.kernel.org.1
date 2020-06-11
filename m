Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB951F6769
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 14:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgFKMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 08:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgFKMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:03:56 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:03:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so5996604ioo.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HQgdpKM4dEN15pdyKHWiwAPArlDUxZ7X6xmIoMk4KoI=;
        b=RLdsocZGxNbIqrwbRaCW9nAGeQdfkcRfB5yY9O+DueBvepvOjkQV8IqxnoEtk2MJXv
         xAse8W7GzRGAtvWUkdhPyzXkKFWPqU1IklWYBJ9daHebL0Jt9EzhNHv98oxbWb3R3Ue1
         aJ0Bj4REGLnCZ5Lc02q3FkpxKZkYAwG5WZuhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HQgdpKM4dEN15pdyKHWiwAPArlDUxZ7X6xmIoMk4KoI=;
        b=sbK1Rfiwwusy1Lsu9ZVhIqHC4r41Qld0ME2FltFh/tiW+wtWFQ2UN0TkcLzoZPbIze
         NXuUjQl1883lifKyR8ds1eADEaFIG7LAhwq2WS6bZqh+VTUtHMgu2/wE52dTVdGY2HKS
         oNUMASXb9MAhqbChXROtBFi0yvUgvsb0Ytx8mpCFx5zwtxIhpRkC4eAfwWvSi/mfZScn
         TbT9ay8eKalf06pDdBBzmhKY1D+IXhWyP+c0xxm4l4aGW4AJwLYsXSPXI4FagTSy6keS
         q1FgLhv0uzDu9rz/TG9Y2uLkxtwYi/o79cVzplXGIZGsHN3GFJzjTJiIGdemR84cLT1V
         xptA==
X-Gm-Message-State: AOAM531h1WcF1IJOSBytvfDy+i0l/rc+ii23+vElHk0bUmbvSP80kyud
        Kdwq85afb3JbZD7q2qjJ1TqNAw==
X-Google-Smtp-Source: ABdhPJyWfGJ1+9lxeSa3Th0z/gkQYgnCXCMBoWdd2c0vXWG7F6qlix9bM8Er5mV/swuR/vh9eQiy5Q==
X-Received: by 2002:a02:298b:: with SMTP id p133mr2918838jap.73.1591877032369;
        Thu, 11 Jun 2020 05:03:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm1367881iog.49.2020.06.11.05.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 05:03:51 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
 <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
 <20200610145535.747d2765d60e6e3923441768@kernel.org>
 <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
 <20200610093206.5b9fb1b7@oasis.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
Date:   Thu, 11 Jun 2020 06:03:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610093206.5b9fb1b7@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 7:32 AM, Steven Rostedt wrote:
> On Wed, 10 Jun 2020 06:04:33 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>> Steve, what would you think?
>>>    
>>
>> No worries. As far as kselftest tree is concrned, I can apply these
>> after rc1 comes out with Tom's patch.
>>
>> Or I can give Ack and Steve can take these through tracing tree.
> 
> All my patches have already made it to Linus's tree. Perhaps
> cherry-pick the commit needed from Linus's tree (it shouldn't break
> anything when Linus pulls it). Just let Linus know what you did, and
> everything should be fine.
> 

Good to know. I will get these in.

thanks,
-- Shuah

