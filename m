Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19A2292C98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgJSRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgJSRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:23:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790EC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:23:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e10so347673pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m9yDz6jsfkl8I4WwGG8Nd/lVTcCTRXN3HWZNgzXsp4E=;
        b=0e95TsUR7v0CLtoa8YRBbvAHeoWB96sc0KKgqqYcvM5oMJTphsnRM52cmcwxle0o4K
         1nYQFXgQDtZ39b6CdsRZkifsV3LwoxGWc6rTmEP/FDiQpb1wz0gwhVA4VZFsmcPTFfMn
         vB3AU3nSWJaKiM8naZerYkjG+c/WkSOzA4iMKVNdxgdfcp9XUftvP8da4Js3obXtWGoi
         CY2mXO6cYc7jQeU39AupOao6iCME+dQyPuDl/7zAV7w7SOX7dAQpYx4onXy4Hqeze1wq
         px02vvtzy1zBetanFakwNOKrRr93MdwIBO1uaUuJXC0lZi7Ul4IlO2jXxcB9xPHhkh8F
         ExjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9yDz6jsfkl8I4WwGG8Nd/lVTcCTRXN3HWZNgzXsp4E=;
        b=VTUFZII4hychzxTDRivZLjRqrXiUZjmGfA7nOLax+tVxDRPXQyTjVhiwQLVKAwB+kS
         AVA9lHPdLUjXWU+r29/7oj/jJM5a4cWxF53W+aBcH5kGo/DUxguXsnMwZDW+csSbxkIy
         x/ud9v6FqcYBiE6PuaWxdUYoj5h8sHO7jjNG8SxZBZDmK3QisYpRXupmBfL/MAdnpCy3
         jl0vYpgydC6tqEjorS9ATXryERa8RfASnEMzhtaDVBIDVaWVowSxiFx+DHo2GwaQAN8F
         79JerWIw2X9LsLOO1xsZAWcvYSJYNKAEYs5DhXuC2ch3vHWDBnfnQmwqJkVVO/cpHtPe
         k17A==
X-Gm-Message-State: AOAM533ryIv/L2pyRcXnaWPTNIAJj63iciKCVOftcN2OjwTf0z1lzsbZ
        BG97U9piSUPaSux3zlpb9L5oIFboL2GNBg==
X-Google-Smtp-Source: ABdhPJwsqWVBKojPmoF3yeXCiHiiQLSVFNz5YucRTA0U9YYMJCFfkI1WoiaRIMRiDX/5XYmhDYI//g==
X-Received: by 2002:a63:1e21:: with SMTP id e33mr631531pge.270.1603128230105;
        Mon, 19 Oct 2020 10:23:50 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c8::169d? ([2620:10d:c090:400::5:499c])
        by smtp.gmail.com with ESMTPSA id b5sm221170pgi.55.2020.10.19.10.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 10:23:49 -0700 (PDT)
Subject: Re: [PATCH] block/elevator: reduce the critical section
To:     Hui Su <sh_def@163.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201019164246.GA79115@rlk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea4495c3-0003-786d-82e4-3693f349890a@kernel.dk>
Date:   Mon, 19 Oct 2020 11:23:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019164246.GA79115@rlk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 10:42 AM, Hui Su wrote:
> @@ -633,23 +633,21 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
>   */
>  static struct elevator_type *elevator_get_by_features(struct request_queue *q)
>  {
> -	struct elevator_type *e, *found = NULL;
> +	struct elevator_type *e = NULL;
>  
>  	spin_lock(&elv_list_lock);
> -
>  	list_for_each_entry(e, &elv_list, list) {
>  		if (elv_support_features(e->elevator_features,
>  					 q->required_elevator_features)) {
> -			found = e;
>  			break;
>  		}
>  	}
> +	spin_unlock(&elv_list_lock);
>  
> -	if (found && !try_module_get(found->elevator_owner))
> -		found = NULL;
> +	if (e && !try_module_get(e->elevator_owner))
> +		e = NULL;
>  
> -	spin_unlock(&elv_list_lock);
> -	return found;
> +	return e;
>  }

This looks wrong as well. If we don't match the elevator, then we just
return the last one. Or maybe even a totally invalid entry, depending on
how the list iteration works.


-- 
Jens Axboe

