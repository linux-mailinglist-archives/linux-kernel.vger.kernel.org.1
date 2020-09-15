Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57F269DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIOFQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:16:55 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:35009
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbgIOFQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:16:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU8C74e38e8Qk07weLp9IIb+/Gkz5XArvyMOko1bUjcYlIHPc7hMU3+WdMZxi0G0GYwRZW7zYZz7UxRexWAB7CSg9AfF6jduzq5LxtDqiLtSvFcQbwTyAF1B8SwqX7gf/e0vIn5ZSYncmzcBMqA8VVbs0kBkxl4JObceO9ELH2vU+r7wDUzrazDH7ke9XWuA5+YhwUeGsEbgwg21ogyFPPb21niTKx4PYD6EjQtKSFoBVEqw1e1OX+/wv+QJpgfF28u10X/+NwrFANHUn73bO6OaEmy7Ffi+HLthRgUsIjJmoAgFSEsqcIJyoFkwnoBJaVFAU990faa1OP0r42sVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVVHBu3GQ8+i+xWY7BJYzYjD2c/aKR/1Qz9LNLo4Z0c=;
 b=kV3RZ1/fMhfvNI62g8hGMx7svcFAbQoIZm3X+PhxesycpDNOjRbx1cymCymb0wm9k9YCqlE0vHcSqDGxxBOwOKTkverOkmAzvJEL1YNBOk4IcZI3anuiqpjOfxvxKSUEHm4GrzTjEVVjmKrkNDqk/PN/H3pRnV3Fjn5qDzSGY1iyJshAHhlOy4ntGo/7F0AGsLl7O7vV4Q4PLwAAHxrRRV1oFq5IpuVJ+lvV2pRocfhHWUAgA4G9zcRrco2lTcpes7/bQQ3g0m/av1Hf5p9/1EDeE1sZUmB6OK/FjIUcvkIaxmMTgtHKIb1yKHEYpRQkGbeMbwqTqbMxbnZJptRGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVVHBu3GQ8+i+xWY7BJYzYjD2c/aKR/1Qz9LNLo4Z0c=;
 b=bhlnk76SSSbT0F8sbpvaHbS8B0V2dywYCCvA2uiGfHM++BU7zXRIqm0KKURbXjRjqqsepUTSOTSV0/6Ade95J0ciRhs8oAP34WFNdbaJcmtRO70iCDkEBopW/xtbgyXtBRI4t6cUeR5ED/bTtX8P/FhLHOLn97FnmlkswYfMi8Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3557.namprd11.prod.outlook.com (2603:10b6:a03:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 05:16:48 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 05:16:47 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUkNVOiBRdWVzdGlvbiBvbiBmb3JjZV9xc19ybnA=?=
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200914194208.GA2579423@google.com>
 <20200914205642.GE29330@paulmck-ThinkPad-P72>
 <BYAPR11MB263207BFF3AFB6A9D1A7A32FFF200@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200915034139.GK29330@paulmck-ThinkPad-P72>
From:   "Zhang,Qiang" <qiang.zhang@windriver.com>
Message-ID: <1079509d-c474-42bd-44e9-18cfa948fbae@windriver.com>
Date:   Tue, 15 Sep 2020 13:16:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200915034139.GK29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by HK0PR03CA0097.apcprd03.prod.outlook.com (2603:1096:203:b0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 05:16:45 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615f5082-94e3-4e53-10e7-08d859368b51
X-MS-TrafficTypeDiagnostic: BYAPR11MB3557:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3557A85FB1A8FFC49ABCBBBBFF200@BYAPR11MB3557.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qy/2jrNGw9DQYYDjKe3Mt+/8KG5ojTnGoQKj/lA41WhBVXmfknZ8CfHSm95tG9MX6iLLq3W50UkCy7o4EBDfJkW+X6qJpzgArKazSJ5/KoWwOsBZpozdKUCiNH5mN3GmvHWWp/PNqs53FuMTFGUWzYyAHT4VDKGS7Yb2TI0djZnrYsDEE+lYqhzGQZb1m3LiKKgKBZYAUhmnZcUNS/d1LU7GTYveI34oNQcVs27HEo5E3ffg1Oq0yVA5rxu99zBnI4AJeOuxW/U9AP/nhxjtR9jGrrSv+GVFSiWR0l58ujUg0j9nfKXdsN4eihmM5fsQXbr/wcVpA0A/mmzZbr0Rl114A6vS2IvtffQQRFHeuxDZ78rBsp3Ni53uZULDvL6XNVSvjd+GwDm3+EHm/es+KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(6486002)(66574015)(36756003)(4326008)(26005)(956004)(316002)(478600001)(31686004)(224303003)(16576012)(2616005)(5660300002)(54906003)(66946007)(66476007)(31696002)(66556008)(6706004)(6916009)(52116002)(2906002)(16526019)(186003)(53546011)(6666004)(86362001)(8936002)(83380400001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nVBTRYL1XmiMtERjDu/0nUl44SSmQQMudTB7tO8LamDeeWQ5uwmFA8P2FgQiWTsNpxaO5ZO+WcFe88KiNXvGymrZrvg/lX1bonvpDfQSdU/RftXGhAU7flxV8R4NH6OG/FdZ4HW0GAaT0eV4yc8QXbK0cTP/Xdt5wVNrymdZfaBo2ORSXM/25OgBN+njZGHdbww/bRXai8eo2lBg87LknhY+zc8Lk44k2oBmYpiYNFOYoiG6Q7QJLaWtpRXytQdWibDl70ZsYGjBXNCD0VShXRnR0Vnm07JkkBrSeQTdOhwERbN5yrizuBpStiuQ5mSU13UO8BRZNApSf6oiM/Qon1vo6gpoBbKFkqbYmxpvk+xkmMza+0suzqK4D6kD4rXIwb6zWYeImxdtJg44hkFBlwuZP5m+0gES/gwXepcc/bp7xE7CSyU7G8Ko9bf0gJPj2mSlJoOYqdI7HJAys/9xucuu6V+9g5RsJ3OhOBRfa3k8qoYl56y53TgXlNV3aJIzhmGzBHRoDKp7UGOVNdZnr10QJGVZM0QFxmutZBm0xNAi8BOgiZGxdnyd+NAxbFbkf1Em0+jrTCcX2Rh4DkrHW/ijtu4fzEBcP2CDbJtG+7DpMNq8+oHjtTC8rzjGIiew2A7zAzzxAxQqTQJGnJb1mg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615f5082-94e3-4e53-10e7-08d859368b51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 05:16:47.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmmOUfw+++qBdnKBnED6uMswIxbGbIg5LBEO4AbibWhmfW2D2XC2NwWpeOwZEmeNvkfUhghsCa/fV71kN4q4IQJHI6TcL/jiYjqc+XXLwDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/20 11:41 AM, Paul E. McKenney wrote:
> On Tue, Sep 15, 2020 at 03:18:23AM +0000, Zhang, Qiang wrote:
>>
>>
>> ________________________________________
>> 发件人: Paul E. McKenney <paulmck@kernel.org>
>> 发送时间: 2020年9月15日 4:56
>> 收件人: Joel Fernandes
>> 抄送: Zhang, Qiang; Uladzislau Rezki; josh@joshtriplett.org; rostedt@goodmis.org; mathieu.desnoyers@efficios.com; Lai Jiangshan; rcu@vger.kernel.org; LKML
>> 主题: Re: RCU: Question on force_qs_rnp
>>
>> On Mon, Sep 14, 2020 at 03:42:08PM -0400, Joel Fernandes wrote:
>>> On Mon, Sep 14, 2020 at 07:55:18AM +0000, Zhang, Qiang wrote:
>>>> Hello Paul
>>>>
>>>> I have some questions for you .
>>>> in force_qs_rnp func ,  if  "f(rdp)" func return true we will call rcu_report_qs_rnp func
>>>> report a quiescent state for this rnp node, and clear grpmask form rnp->qsmask.
>>>> after that ,  can we make a check for this rnp->qsmask,  if  rnp->qsmask == 0,
>>>> we will check blocked readers in this rnp node,  instead of jumping directly to the next node .
>>>
>>> Could you clarify what good is this going to do? What problem are you trying to
>>> address?
>>>
>>> You could have a task that is blocked in an RCU leaf node, but the
>>> force_qs_rnp() decided to call rcu_report_qs_rnp(). This is perfectly Ok. The
>>> CPU could be dyntick-idle and a quiescent state is reported. However, the GP
>>> must not end and the rcu leaf node should still be present in its parent
>>> intermediate nodes ->qsmask. In this case, the ->qsmask == 0 does not have
>>> any relevance.
>>>
>>> Or am I missing the point of the question?
>>
>>> Hello, Qiang,
>>
>>> Another way of making Joel's point is to say that the additional check
>>> you are asking for is already being done, but by rcu_report_qs_rnp().
>>
>>>                                                         Thanx, Paul
>>
>> Hello Pual,  Joel
>>
>> What I want to express is as follows :
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 7623128d0020..beb554539f01 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2622,6 +2622,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>>                  if (mask != 0) {
>>                          /* Idle/offline CPUs, report (releases rnp->lock). */
>>                          rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>> +                       raw_spin_lock_irqsave_rcu_node(rnp, flags);
>> +                       if (rnp->qsmask == 0 && rcu_preempt_blocked_readers_cgp(rnp))
>> +                               rcu_initiate_boost(rnp, flags);
>> +                       else
>> +                               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>                  } else {
>>                          /* Nothing to do here, so just drop the lock. */
>>                          raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 
> But in that case, why duplicate the code from rcu_initiate_boost()?
> 
> 							Thanx, Paul
> 

Hello Paul

When we force a qs for rnp, we first check the leaf node "rnp->qsmask" 
if it is reached zero, will check if there are some blocked readers in 
this leaf rnp node, if so we need to priority-boost blocked readers.
if not we will check cpu dyntick-idle and report leaf node qs, after 
this leaf rnp node report qs, there is may be some blocked readers in 
this node, should we also need to priority-boost blocked readers?

Thanks

Qiang


