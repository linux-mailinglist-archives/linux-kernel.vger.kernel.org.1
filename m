Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7526E9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIRACO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIRACN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:02:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:02:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q12so1988159plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Z6/uk13fDdDtxzok5bqvhcNjwfgQSfjItx45RAkKMM=;
        b=hsbyNOmNnu+3dyU50HMPOINq4tVVRyHudxgOhWxe4IOJlFnaIC9FCiM+bC0ZcI/Akk
         VUSzXPk2hc/0qRqxyvt4ivB+71QU4yuBzD8zkngQg6bCqFCiw94eQbxZMRpbMTgAsFNt
         jHtkzEEt5TJgQ1ZHYWWZcVsaz3FYnpls9py69nYJJN+1lhqNr6op4zF4Ch4xl4G6XTNs
         3C60yRDAghia+qJVohd78KAYk7wRrdmAdX80qll/P86Anb5y71VDJ8HWgUTzhEumWwcB
         NL+NoGnzRH4Kg/T6jRZ3ynx/dw4lr8P72jVu8m8HXobN7pccHHcMuP8J4eO9iIZN/xCd
         sdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Z6/uk13fDdDtxzok5bqvhcNjwfgQSfjItx45RAkKMM=;
        b=e6dyG40MsPl6BaFwQfH4ci0D7pdJ9iCyWWnngGUqwJ6nN8DMLeIWELtZhazUhvNomq
         WeXf2IqaWXigQY7fl7EhR40Oi41wWJ3NUV6QzA3G76rO9F0FI4nU/Ec83Bc+Sm1/knaR
         V4qDUOUc07rNlNB7K3P61QaHV6nua13CMu0wkKuJAY5UCYYgPe2m+H7D4vZphOClRU2L
         x3kPxDoI3Bjp1NtZHjZQ7ZzCGJJpXI/FOL2QaJ7fK5jwYW8K9eyNNQovjs+jIjmiaGw5
         skWPm2Qc17zFE7+RlPQyH3L2bBhwSvBuRkAVyuxo8aAKBUxmPUq7PQxiLjPzrgwrDPM7
         MdJw==
X-Gm-Message-State: AOAM531NpuHEd+BfUvyw/f27bzBBB7hublfr/TL5/ldBxvWLxRY0CEzW
        KkQueI8VJwh/L3dMIU54qSfuwQ==
X-Google-Smtp-Source: ABdhPJwQp2qR21KZabTeKaqQ56ZDW9ZR64gwodC+vJPyOYuI3+yKcUAEIuLEVY70q4dA9tJ1lJbS5g==
X-Received: by 2002:a17:90a:fc6:: with SMTP id 64mr11048059pjz.194.1600387332194;
        Thu, 17 Sep 2020 17:02:12 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 16sm749246pjl.27.2020.09.17.17.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:02:11 -0700 (PDT)
Date:   Thu, 17 Sep 2020 17:02:03 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     fruggeri@arista.com (Francesco Ruggeri)
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xiyou.wangcong@gmail.com, ap420073@gmail.com, andriin@fb.com,
        edumazet@google.com, jiri@mellanox.com, ast@kernel.org,
        kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v3] net: use exponential backoff in netdev_wait_allrefs
Message-ID: <20200917170203.1a363082@hermes.lan>
In-Reply-To: <20200917234953.CB1D295C0A69@us180.sjc.aristanetworks.com>
References: <20200917234953.CB1D295C0A69@us180.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 16:49:53 -0700
fruggeri@arista.com (Francesco Ruggeri) wrote:

> The combination of aca_free_rcu, introduced in commit 2384d02520ff
> ("net/ipv6: Add anycast addresses to a global hashtable"), and
> fib6_info_destroy_rcu, introduced in commit 9b0a8da8c4c6 ("net/ipv6:
> respect rcu grace period before freeing fib6_info"), can result in
> an extra rcu grace period being needed when deleting an interface,
> with the result that netdev_wait_allrefs ends up hitting the msleep(250),
> which is considerably longer than the required grace period.
> This can result in long delays when deleting a large number of interfaces,
> and it can be observed with this script:
> 

Is there anyway to make RCU trigger faster?
