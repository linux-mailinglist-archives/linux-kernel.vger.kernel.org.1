Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC41C47C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEDUQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 16:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgEDUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:15:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B717C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:15:59 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 23so68939qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=qaBBk/smpYuQoJcHKGIGXo6xcNtXI58RrNOOaDplxxU=;
        b=wDsu96lxuidwPq/rIpPZu8gJisG82ozSRJ7NNj6ko7TtFdbAeYJGVjk6aOy3pV+CtW
         ajeSYBT41xX1sTt6eCX/FHevjVPJyrOfi9VjVOXFg9SRlaJ4gbccoLaaPymVcY4B3j90
         ynUnlrHKv8DrlIgreWhw0bnqw7mXdjv7OQzoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=qaBBk/smpYuQoJcHKGIGXo6xcNtXI58RrNOOaDplxxU=;
        b=Ke29Pg0Zd/uUaOoJ5WjWd8uoL4aJNOvHgyFzBmN8PYJtL3GtyTl/6sktMD6jQX8e9E
         llYFs5OK7zlNpveMOG+r0calnd++dz4hcN0/QjugCDUC3WAUWrs6rdXw9zDxJG0RUWRD
         HKCm+0cxbH0cncUQ1vIFFKF36kwLMVsDyvETAaMa4a6+y1ZqtU7kqGB8894QfqIOETTD
         GqDxK7F9qsQuf+fQQFZtbAAsbKeJ9Aj70nCfd1ZgD8O02Ckpd+2ixqCRQUZ6iUAm42p6
         FRPe1q7UTOOQR/HRrnaoEH730X8xqtcc49d3QyR4nD909Wr4G5BsbwOIOicI/lDYcVdq
         BW+Q==
X-Gm-Message-State: AGi0PuY6ZwokDnS7gFe/1vh9N5PzSRixfAkVKfbPc7YcGC/UjvXg7yDP
        8wppH8josK3ck0Yyo7jcyrJR6g==
X-Google-Smtp-Source: APiQypJ9UKDVGdImohIT4xO2OUyTFH6NvTu5Y1esqKZOwoVgIWuTkX4/x6/btb32Dtv51R4Y2vZh6A==
X-Received: by 2002:a37:8d6:: with SMTP id 205mr120790qki.144.1588623358353;
        Mon, 04 May 2020 13:15:58 -0700 (PDT)
Received: from [192.168.1.8] (c-71-62-121-229.hsd1.va.comcast.net. [71.62.121.229])
        by smtp.gmail.com with ESMTPSA id i42sm12553327qtc.83.2020.05.04.13.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 13:15:57 -0700 (PDT)
Date:   Mon, 04 May 2020 16:15:55 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20200504195128.GA21830@pc636>
References: <20200428205903.61704-1-urezki@gmail.com> <20200428205903.61704-10-urezki@gmail.com> <20200501212749.GD7560@paulmck-ThinkPad-P72> <20200504124323.GA17577@pc636> <20200504152437.GK2869@paulmck-ThinkPad-P72> <20200504174822.GA20446@pc636> <20200504180805.GA172409@google.com> <20200504190138.GU2869@paulmck-ThinkPad-P72> <CAEXW_YQmrfbaDocsc7bLULRR1yUv4=MMMEw3b0s1mXM8sEVVzQ@mail.gmail.com> <20200504195128.GA21830@pc636>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
From:   joel@joelfernandes.org
Message-ID: <2A623E6F-878C-4C1F-9045-56710DE7851B@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 4, 2020 3:51:28 PM EDT, Uladzislau Rezki <urezki@gmail=2Ecom> wrote=
:
>> > > Since we don't care about traversing backwards, isn't it better
>to use llist
>> > > for this usecase?
>> > >
>> > > I think Vlad is using locking as we're also tracking the size of
>the llist to
>> > > know when to free pages=2E This tracking could suffer from the
>lost-update
>> > > problem without any locking, 2 lockless llist_add happened
>simulatenously=2E
>> > >
>> > > Also if list_head is used, it will take more space and still use
>locking=2E
>> >
>> > Indeed, it would be best to use a non-concurrent singly linked
>list=2E
>>=20
>> Ok cool :-)
>>=20
>> Is it safe to say something like the following is ruled out? ;-) :-D
>> #define kfree_rcu_list_add llist_add
>>=20
>In that case i think it is better just to add a comment about using
>llist_head=2E To state that it used as a singular list to save space
>and the access is synchronized by the lock :)
>
>IMHO=2E

Sounds good to me=2E thanks,

 - Joel

>
>--
>Vlad Rezki

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
