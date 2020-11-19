Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE052B9E60
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKSXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKSXcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:32:01 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61198C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:32:01 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 81so5687843pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xw+g+F80uZmD1GmLRMgTYJeVANg0df1WU0QZmgwAnXY=;
        b=FXg4YhoYxuvVKCRaP+Z4oXHYagXHA+E9YIEQRET2goUn0QFD5+KIF3vYerqOq4aiMT
         TDHoN4RKfzrNh1/s8ui6eo+Jd8sBJbNSvWZo+4oLqYXNN/ixs97D2PQpSC13IFi+v3qm
         Sx00zxvjiKIJkxTy6WOmoEjI3UCmwyVlwNbrRcltuwlK0MN6k11yb0sJNvj9GRZQrgLY
         DPjFfygorfvXrqlN33IHovaiIFHCFCH0s8dI0sUQQMmMn3kXz3e1PLf1YIygc5aB2LSs
         121iS4OXCAJeyV7Es+ncZW6O/ixIoV0sFF9Y1Qdb22iwvPl12TBrGF+w8SdbGICqEvnO
         ULng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xw+g+F80uZmD1GmLRMgTYJeVANg0df1WU0QZmgwAnXY=;
        b=K9ToiuUhcVXKqH5ZcvZ6bV2t61wtYc5JS9BIId8dmrGIttQPb4Od16+RvEjpDY/urV
         afKQdS4Pc8lnlOBKkWkW4rysecL7hM4MyKjClZoX5nFQglu2LiC/K0iMSgj8E+pgdEV0
         yzHXbhtpZFCt/zl9jYk7rKm7JZ93roj1m+4Q5mxR9wTDoqtYBXhbJ/OX9Efg1Sf6piGf
         cLNlRXnAd+pJ46r3bn88klhfak4J0QyPVBqj/WV2hZE2uVpFdNc0XmZqKVzXUrCabX6t
         bo8hYvhj6cvIEmtulXshSEMXnUPDG9F3BRgriGZgp5lpkBkCf5LAFEZ8cnSGWyhaGFKz
         J4hg==
X-Gm-Message-State: AOAM533rn1JKv9HPLSV0j/T9p11cW63Av6a4MYqKBAB42UBOdfNzhgXi
        +1cTEfJtlKEVgPO5DewyKfI=
X-Google-Smtp-Source: ABdhPJxPHYyjJ4HJ6b2nEo+vep/0O4tHnLBu0wBGidg0MUk+J1JRkRq7hTUXlmPVs8EVJ6Z2fNRPog==
X-Received: by 2002:aa7:9f0c:0:b029:18a:e524:3b90 with SMTP id g12-20020aa79f0c0000b029018ae5243b90mr11414788pfr.77.1605828720703;
        Thu, 19 Nov 2020 15:32:00 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id m18sm1030821pfk.10.2020.11.19.15.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 15:31:59 -0800 (PST)
Subject: Re: [PATCH -tip 01/32] sched: Wrap rq::lock access
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-2-joel@joelfernandes.org>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <1489211d-594c-d244-0111-8bd8a27fb945@gmail.com>
Date:   Fri, 20 Nov 2020 10:31:39 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201117232003.3580179-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> In preparation of playing games with rq->lock, abstract the thing
> using an accessor.
> 

Could you clarify games? I presume the intention is to redefine the scope of the lock based on whether core sched is enabled or not? I presume patch 4/32 has the details.

Balbir Singh
