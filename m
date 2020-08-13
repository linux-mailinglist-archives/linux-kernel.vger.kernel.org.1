Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34267243B63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:18:35 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A545C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:18:35 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dd12so2698946qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=io/itjk96ZRapnu7iOLsNsisZdejFgQzv7AVwMEFP5A=;
        b=KMyOCC4VMXuYH2VOgl8Qc0e8jMWANokc64UrBIleS4tAVnyf8NsnIPi451MLUUGwoi
         9UtTtw7ohSE4Wuq2LzHWfDKkMO/zSM0c3AUYjkHMgBbrdR8Nf2DuXIkuBTX8Jay5vUun
         vsmqWj40tx2+La4bpp9jR54R/9DlvvWzpDOcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=io/itjk96ZRapnu7iOLsNsisZdejFgQzv7AVwMEFP5A=;
        b=rNz/vPFADtSIyjywHKK3sxuTWFVUUp5GwIib9pQU2TonMRcRcDojwd+5EqBaZmSGXV
         0H+W23zlbHW5IFEEI1LBMoI3w+aDv3/NKbJJb4yrenn9yd/zTsZR8n9R+IVS/kFMpM91
         uUbdhUNpi9SrUQl71evdNRsenEftMd2p0C31svh2rJzPVFqtkFs9arKZWVBY2pqOYWqO
         HlWaMUnTzZXMdKzorOdRdXy9jlqlhh891rO8D59bq9hDZHbqz4O7gLkW92W8n8tzVD9m
         8VYxtDOmCK99hUId8mjOUNjooySW1zgrYAZEyw2TJ65f/5FSTBL/bftOz2HPLghN1SHA
         wGyA==
X-Gm-Message-State: AOAM530GJ/u8Urg1iaqFLcKilCZrcN7fzLMXm2QUSZd53RLMvMx5NqZt
        eLmbuhIpqcGRvMv7zGPbr9mUQ8ZN9ocRzA==
X-Google-Smtp-Source: ABdhPJxcgUfB8TEmB7mwLoGdKXX5ajsn6EjZCxSTVNtpO7VyrMCg6Tzed0bEmjO/U+1wBeibr99Sgg==
X-Received: by 2002:a05:6214:154a:: with SMTP id t10mr4848123qvw.146.1597328314477;
        Thu, 13 Aug 2020 07:18:34 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id z24sm5198023qki.57.2020.08.13.07.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:18:33 -0700 (PDT)
Subject: Re: Linux Foundation Technical Advisory Board Elections -- voting
 procedures
From:   Laura Abbott <laura@labbott.name>
To:     "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name>
Message-ID: <da2664b5-a197-4bad-6361-42c271e5fa0f@labbott.name>
Date:   Thu, 13 Aug 2020 10:18:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 5:31 PM, Laura Abbott wrote:
> On behalf of the Linux Foundation Technical Advisory Board (TAB), I'd
> like to announce the voting procedures for the 2020 TAB elections.
> The pool of eligible voters will consist of the following:
> 
> 1) All attendees of the Linux Plumbers conference (i.e. kernel summit)
> 
> 2) Anyone who is not a kernel summit attendee will also be eligible to
> vote if the following criteria are met:
> -- There exists three kernel commits in a mainline or stable released
> kernel that
> --- Have a commit date in the year 2019 or 2020
> --- Contain an e-mail address in one of the following tags or merged
> tags (e.g. Reviewed-and-tested-by)
> ---- Signed-off-by
> ---- Tested-by
> ---- Reported-by
> ---- Reviewed-by
> ---- Acked-by
> 
> We will be using the electronic voting method that we used in 2019. All
> Linux Plumbers Attendees will automatically receive a ballot. Anyone
> who is otherwise eligible to vote should e-mail 
> tab-elections@lists.linuxfoundation.org to request a ballot. The deadline
> for requesting a ballot is August 17, 00:00 UTC (one week before
> Linux Plumbers)
> 
> For those who would like to know the thought process behind this:
> 
> Last year, we successfully used electronic voting for the TAB
> elections. Given the circumstances of this year, we have no other
> reasonable option for voting. While we could continue to limit voting to
> kernel summit attendees, one of the goals of moving away from in person
> voting was to potentially expand the voter pool. Since kernel summit is
> not being held in person this year, it makes sense to expand the voting
> pool at the same time.
> 
> We will be sending a call for nominations and announcements about
> when voting will start at a later date.
> 
> If you have any questions, feel free to reach out to the tab at
> tab@lists.linuxfoundation.org

As a reminder, this vote is coming up. Some FAQs from last year on
virtual voting:

Q: What's the software used for voting?
A: We will be using the hosted version of the Condorcet Internet
Voting Service (CIVS) at https://civs.cs.cornell.edu

Q: Is this code open source?
A: Yes. The code is available under a BSD-like research license

Q: Is this method of voting secure?
A: Privacy and security is a focus of CIVS. See
https://civs.cs.cornell.edu/sec_priv.html for more information.

Q: The website mentions ranked choice voting. What is this?
A: In ranked choice voting, you rank your preferred choices from most
to least liked. The theory is this results in a more accurate
representation of what the voter pool wants.

Q: The description mentions an 'election supervisor'. What is this role?
A: The election supervisor's role is to start and stop the poll, send
links to voters, and set various options for the poll. A single e-mail
address is used to e-mail the link to manage the election, after which
anyone with the link can manage the poll.

Q: Who is the election supervisor for the TAB elections?
A: We have created a mailing list for election management, 
tab-elections@lists.linuxfoundation.org

Q: What if I lose the e-mail before I vote?
A: Please e-mail tab-elections@lists.linuxfoundation.org

Q: What if I want to change my vote?
A: This is not possible, please make sure you've made your final choices
when you click submit.

Q: What if I want to practice voting?
A: CIVS has a number of sample polls available. Feel free to vote in 
those to see how the process works.
