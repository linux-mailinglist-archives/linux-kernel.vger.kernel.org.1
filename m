Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2944928450F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgJFEsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:48:39 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44531 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgJFEsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:48:38 -0400
Received: by mail-ej1-f68.google.com with SMTP id a3so15636416ejy.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 21:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8EPhmi+b3LSXVas4Pi/6tHD819FKsgGjoD8WRd/SEEI=;
        b=pMOO2mWYV2O8G4YsXM1gaX07YEajrGNwqftZvnZYZrrZAK65sODJaHIqibIVQNJCTC
         WPQYOyS/0CFMGTgzeWWMGjKbV7n9e1Oqps9vfzB83e6eRr9PQAUF//9+JvXF615t+gSi
         GOZOLgTfFH/tRec2ZPzSTTs4XEHnOCj182Qe3pLGcAG68MqtiwyOajo8wXejNGYuz9Qo
         Gwe+LV/QVZGVujR33pKKqs86t5wlSGIiwlDFmwB8nrIXXF0I/tu2pw8y1/Jk09SV8Gg1
         4HaQBOE05Lwi/5dRTy5wBjHO/UpRFilYs7Us62z5/7yvEFocfntZzjzxLWj3h6SHi+q/
         cB+A==
X-Gm-Message-State: AOAM532A9gbGYeUlI4Sf1lyiRwYYQv5UbWkjWgQXG00RAeTQs3n47Abx
        XTzp/EbtJWNPhBAaUWmSeno=
X-Google-Smtp-Source: ABdhPJxkG7XMOt1pIyGobMQA6cuQQyWsXd/2CdwzyYMjiaMzWf+409kZY1PpG3sPedKxARJM2rvFIg==
X-Received: by 2002:a17:906:696:: with SMTP id u22mr3205693ejb.446.1601959716921;
        Mon, 05 Oct 2020 21:48:36 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id n10sm1394461edo.55.2020.10.05.21.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 21:48:35 -0700 (PDT)
Subject: Re: [PATCH v2] drivers:tty:pty: Fix a race causing data loss on close
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, minyard@acm.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>
References: <20201002130304.16728-1-minyard@acm.org>
 <20201005113149.GA444220@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <36dd1306-e14f-431b-a6b5-82da3868307b@kernel.org>
Date:   Tue, 6 Oct 2020 06:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005113149.GA444220@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 10. 20, 13:31, Greg Kroah-Hartman wrote:
> On Fri, Oct 02, 2020 at 08:03:04AM -0500, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> If you write to a pty master an immediately close the pty master, the
>> receiver might get a chunk of data dropped, but then receive some later
>> data.  That's obviously something rather unexpected for a user.  It
>> certainly confused my test program.
...
> Jiri, any thoughts about this?  At first glance, it looks sane to me,
> but a second review would be great.

Hi,

I haven't had a chance to look into it yet (labsconf this week). Moving
it upwards on my TODO.

thanks,
-- 
js
