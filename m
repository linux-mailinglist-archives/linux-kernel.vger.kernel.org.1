Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104B1F5DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 23:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFJVdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:33:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C718C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:33:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so1451273pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Lb4h1PwPnUVJ7YIBu19ZrnGGjkU+MTILqgfz1Ny6goM=;
        b=XrCd/2SxgPYEHxKkXjPyfZ8nKu9BMzOdkhZ01+4EayMZmAk+YXg7qUusM1306LeO4u
         xlSPdwHaB2iMMaajirbefHn3EBFyo5jhiZja5JW3sM2WQNnGcleE1fMYDZejfhk7co5y
         wL04Mlu8aYmEmhwVnWXrAgNxK8vCZsgXd3MZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Lb4h1PwPnUVJ7YIBu19ZrnGGjkU+MTILqgfz1Ny6goM=;
        b=K/Sfi1K8cSlBtjxM5EjXszLnzSCA9+UtQpFMsP2X4Np3+H2CTN/vqWv67qAN+Xnypv
         K84li3N2pIto2wljmyCwslZGsEpQ4JZhXYRUUgG8IXoZ55xza5Fm3l3GURc+64z9iNw/
         kkwpEzJuNDkeGgLvOWjItt9E2uluvQw7dgEG+HFFQxMjI9Rt5bXFH2sylfuCsGrxnLOW
         cKouQ9wVH14XDoEk9BDm1vNdJ0nLujKPWRUyCZAMs8ZYyXCSDfvlCV8gcdN1TBedOcQo
         slNSolsSCuC/dkuEqSqUw7+U7lV1xGFN7Gu1lTveQzg7+ABaePWgLftCSVCGoYffodiL
         WpfQ==
X-Gm-Message-State: AOAM530aHKzoBLxvXy0mfEYX6zvff6IdQDNm3ZVO4OfY77iWoDDvJT4q
        tfT8vwI7wTabVeWhZeW2VPte6sFmuYToHuE4M1tsNtCA1ZCPM12kI2KSoj8vM+/MsN6axK1cJh5
        l/zSXDU3I1iLQMFB4SVfCFXFceDy6AMMEMmIPk+mXxbKcoi+PpX2aFFO4o5r6Zig+pRpOpfY/Dr
        norcWG2ZzDs7w=
X-Google-Smtp-Source: ABdhPJyvUMqY6pHlpYWDX++xWhTNHe9XfICi0dJPh+9ZzLMpSsza6+SV1bwaDl082tbmQf46a2/Jag==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr4683208plk.45.1591824797219;
        Wed, 10 Jun 2020 14:33:17 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m7sm677217pgg.69.2020.06.10.14.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 14:33:16 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: add check for
 NONNETWORKING_BLOCK_COMMENT_STYLE
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20200610202640.9020-1-scott.branden@broadcom.com>
 <673c2ebaf7a1ca93f3b1192a77ff62167badd896.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <021da2ca-a8d3-d0ad-28c3-6a84464353fd@broadcom.com>
Date:   Wed, 10 Jun 2020 14:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <673c2ebaf7a1ca93f3b1192a77ff62167badd896.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2020-06-10 2:16 p.m., Joe Perches wrote:
> On Wed, 2020-06-10 at 13:26 -0700, Scott Branden wrote:
>> NETWORKING_BLOCK_COMMENT_STYLE is supported by checkpatch but there
>> doesn't seem to be any check for the standard block comment style.
>> Add support for NONNETWORKING_BLOCK_COMMENT_STYLE to check for empty /*
>> on first line of non-networking block comments.
> I think there are _way_ too many instances of this form
> in non-networking code to enable this.
>
> $ git grep -P '^\s*/\*\s*\S.*[^\*][^\\]\s*$' -- '*.[ch]' | \
>    grep -v -P '^(drivers/net/|net/)' | \
>    wc -l
> 51407
That is true about many things that checkpatch now checks for that 
didn't previously.
But, by adding to checkpatch the coding style clearly outlined in 
coding-style.rst can be followed:

The preferred style for long (multi-line) comments is:

.. code-block:: c

     /*
      * This is the preferred style for multi-line
      * comments in the Linux kernel source code.
      * Please use it consistently.
      *
      * Description:  A column of asterisks on the left side,
      * with beginning and ending almost-blank lines.
      */

For files in net/ and drivers/net/ the preferred style for long (multi-line)
comments is a little different.

.. code-block:: c

     /* The preferred comment style for files in net/ and drivers/net
      * looks like this.
      *
      * It is nearly the same as the generally preferred comment style,
      * but there is no initial almost-blank line.
      */
>
> (with a few false positives)
>
> Does anyone really care if non-network code uses
> this style?
Yes we do.
Consistent coding style is great and keeps your brain able to focus on 
what matters when it is consistent.
>
> 	/* multiline
> 	 * comment
> 	 */
>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3408,6 +3408,16 @@ sub process {
>>   			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>>   		}
>>   
>> +# Non-Networking with an empty initial /*
>> +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
>> +		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]/ &&
>> +		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
>> +		    $rawline =~ /^\+[ \t]*\*/ &&
>> +		    $realline > 2) {
>> +			WARN("NONNETWORKING_BLOCK_COMMENT_STYLE",
>> +			     "non-networking block comments use an empty /* on first line\n" . $hereprev);
>> +		}
>> +
>>   # Block comments use * on subsequent lines
>>   		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
>>   		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*

