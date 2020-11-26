Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28052C5143
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbgKZJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:30:13 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:37394
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbgKZJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:30:13 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id DF054448EE0;
        Thu, 26 Nov 2020 17:30:11 +0800 (+08)
MIME-Version: 1.0
Date:   Thu, 26 Nov 2020 17:30:11 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: Roundcube Webmail: Server Error: Failed to send fetch command
Message-ID: <5b93da4f118ec3e987e83ae41a42fa06@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Roundcube Webmail: Server Error: Failed to send fetch command

Good day from Singapore,

This is a personal experience. I use Roundcube webmail, which comes out 
of the box with CentOS/Control Web Panel (CWP) web hosting control 
panel.

After my Inbox reaches almost 200,000 email messages, I frequently 
encounter the following error:

"Server Error: Failed to send fetch command"

My Inbox fails to list messages even after multiple repeated attempts to 
reload. Using Microsoft Outlook to delete all the email messages in 
Inbox and then emptying the Trash/Deleted Items does not work.

After *briefly* searching the internet, I found the solution. The 
solution can be found in the following article.

Article: Standard Webmail (Round Cube) slow performance mitigation

Link: 
https://community.plus.net/t5/Email/Standard-Webmail-Round-Cube-slow-performance-mitigation/td-p/1661899

The solution is quoted as follows:

[QUOTE=Townman]

The SUs have had this under constant review with Plusnet.  After many 
months of looking at the obvious likely causes, it now looks as though a 
performance issue within the Round Cube Webmail client has been 
identified as being a significant contributor to the end user experience 
of slow loading email lists.  Though other issues have been found and 
addressed, this one remains under investigation.

There is however a simple end user mitigation for the issue, which tests 
have shown makes a SIGNIFICANT performance difference.  The issue 
appears to be related to the mail list display sort sequence.  If a user 
has EVER changed the sort list from the default setting (none) - which 
lists newest email first - to something different … and then switches 
back to most recent item first using the column sort toggles, this DOES 
NOT result in the same configuration as per before changing the sort 
sequence.  There remains an explicit sort setting which gives rise to 
the performance issue.  Not exactly an obvious expectation.

To set the sort sequence back to the default setting requires EXPLICT 
user action...

1. Log into webmail
2. On the inbox list screen select LIST OPTIONS which is the little grid 
icon on the left of the column title bar
3. Set sorting column to NONE
4. Click save
5. See the mailbox list display nearly instantly

Work continues to identify the cause of the delay in retrieving a sorted 
list. Squirrel Mail (Basic webmail) does not suffer this issue, so might 
be more pragmatic if you have a large mailbox which you wish to view in 
a sequence other than by date, most recent first.

[/QUOTE]

Mr. Turritopsis Dohrnii Teo En Ming is very happy to have solved this 
problem/issue with Roundcube webmail, because I will be able to use 
Roundcube webmail anywhere in the world.

Mr. Turritopsis Dohrnii Teo En Ming, 42 years old as of 26 November 2020 
Thursday, is a TARGETED INDIVIDUAL (TI) living in Singapore.






-- 
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: 
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's 
Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the 
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
