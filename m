Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6166C298120
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 11:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415024AbgJYKBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbgJYKBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 06:01:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBB7C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 03:01:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b23so4350802pgb.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q13Jql1sdI804M5ZiLBZ94tm21VCHGnpKBlZzlDjLjs=;
        b=ZzTbgpTB6dDexvdKHQ9yYQbFZNwscgxoibXRpvz0vbVOjwIaNAV//PEe+mm8Jtb0sX
         O2DqR0WP1RcpyiQnkTX4HL8Nj1gh1QI3G9bzi795gy30Uknl8yJ3Voiee15cuns4eEJE
         Csxsg+rwMQ3/9wp/nCcxv+Xvi5Kic/oKbjIr5zJyUinoGGJS9Z96s6nLnL+vP6qhOAEJ
         1uY9bPDL7TrYH/ZfW0lOksLKLRQscxdHiMG5OQzFjwT0wtVE0hRmcJmqATiPcKQCHyKQ
         frDDbOWUj/We3mUEQO4OHwK2tnwqlhHeVP9DO8qoNnu2K1bl2f4NX9BpDH+8PeLglfP6
         DEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q13Jql1sdI804M5ZiLBZ94tm21VCHGnpKBlZzlDjLjs=;
        b=qbrIJype65dtdp/jUK5rOQ4DIVO/Pp73Zn0R02KwcoegE05DPefgHlCMyps/QggR21
         2g2iFfQKXE1xAuvwUy3x87YcC3Sz0OcyAsC8gXj8tJ6ssHsuOaB7SiZjmh1/WnyYj2wG
         GIKNIcKf8rhw6LSvwMw2eS89lx5lhCcQ2P97YGp8UgQbnsZssrqMsXwQgPRx9HUN6F1L
         bdyJqntVXHOLLuDLSJoJ16HVA8k1EcbBv9nA5JwdMGfXo4GVj1zqHJT5ZN0uP0xFfCKc
         qVDNeMRZPPP5pcqj2wbQiHHGywiMQo8HBEpd28yutRNGbZN9fdd+3C7S7GUA80t5F/ej
         ATQw==
X-Gm-Message-State: AOAM530vJC+v6u1TrO1DkOLXriJssqS8ujsSVmnT9XouJJmK4oLzH4Ar
        w3RSkwEeWmPuSPSMotLRees=
X-Google-Smtp-Source: ABdhPJzjT6JBVEW8fIjIbts7DQiRyWR/R88GdNW0hTa+XNKLrBRhVs5EEF8V2HuSWFFo4CUdTh0OzQ==
X-Received: by 2002:a63:e40e:: with SMTP id a14mr11465635pgi.222.1603620074459;
        Sun, 25 Oct 2020 03:01:14 -0700 (PDT)
Received: from ?IPv6:2402:3a80:40f:8add:e07b:1496:e76b:799? ([2402:3a80:40f:8add:e07b:1496:e76b:799])
        by smtp.gmail.com with ESMTPSA id bx24sm9350331pjb.20.2020.10.25.03.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 03:01:13 -0700 (PDT)
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
References: <20201023133828.19609-1-yashsri421@gmail.com>
 <alpine.DEB.2.21.2010232104150.11676@felia>
 <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com>
 <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com>
 <alpine.DEB.2.21.2010250627370.6697@felia>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <091ba604-d5a3-fe13-f13b-6b7e31ec63f6@gmail.com>
Date:   Sun, 25 Oct 2020 15:31:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2010250627370.6697@felia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/20 11:21 am, Lukas Bulwahn wrote:

> This is a nice idea as well. And I recommend to do this kind of research 
> looking at checkpatch and clang-format; both will not be the 'final tools' 
> but I think if you can identify a good mix and combination of those two 
> tools, we will get a good step forward of documenting the 
> commonalities and differences of coding styles in the different 
> subcommunities (the preferences of specific maintainers and subsystems).
> 
> A last nice idea to consider:
> 
> I would like to have an interactive checkpatch.pl mode where an authors
> can say that they ran checkpatch.pl, seen the warning and errors 
> reported, but disagree and comment why they disagree. Then this kind of
> information is added to the patch in a non-disturbing area of the patch
> and we can pick up and aggregate that information from the patches to see
> the complaints, false positives to address or suggestions which rules
> should be disabled for some subcommunities.
> 
> Aditya, your task is now to make those ideas more specific and write down 
> a one to two page project proposal for the mentorship. It can be to some 
> extent in bullet points as long as it is roughly understandable to all of 
> us what you plan and would like to do.
> 
> With that proposal accepted, you have shown to be applicable to the 
> mentorship program here and we take care of the last organisational points 
> before the start.
> 
> Lukas
> 

Alright Sir. I'll be sending my proposal in few days time, on the
basis of my formulated ideas.
Will let you know if I face any doubts during the procedure :)

Thanks
Aditya
