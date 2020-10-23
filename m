Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE942976DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbgJWSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:23:26 -0400
Received: from mail-eopbgr750112.outbound.protection.outlook.com ([40.107.75.112]:49540
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754637AbgJWSX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:23:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzHwR+SDRrgLInP6lOo+FLL6Rd7McC/CN6tnXjcA62dkNr4G9DVdi6zZ1n9k+qcEXfEGYBELLMVLwAIt0lrXyPc64Hn8pjJKBqG4UYXkX2H000Wzp2m015U8Okc2RtnritiW1itdiNKpUoMkaJpZyYGF28Jmwy3W43Y5Xojt0yN4IRuF36lLskWIhD7c5/LF3iRVAqQnMGnZR9RckkqFVoouzf+1AF31CBFfnc0hUFc2yg2Rl8KY7AJf+M/lS33ETJZ+A0fwk9up5P9/zSl8/1rz1bVSgVhf6XfDJxkEeGYLmWkDKTgcYaVKGTBTx+2e6yc8bv4gqpSrxuRAXSpN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvnnOKE/oKsqvbY02iptZ9C93v/99UAbMlLvR1mrwHY=;
 b=l6xTMxDidhVscztfwAyuMGoPTaKR/n0nJPGCIqfxgnlgQHtNmq6OfaL/ibGSxFhvDjt+jXDVN5DiaFcE5IUNW9m35w1D4gZApfrNBV69sREEh9woiG/IlRVkk+EZPCKTquRiPQiFF2J1CPJH6XSkBQ44t4akC7hRl6UhhF3gtD6UlUehC0zo4K7MI7kMTxIDTQ0wn7J4jhKSmLySus4l0WYkmk4zxh05xXUG/+0NXUGI50+e1HKzbiovHhrKKFOCU3UhYvMrOnb9duiKpVXdopjxaAXGSx4JLaf0BKibpX9hUraPDYJblS7mSxFrZm52igEOIzYoF/PjckzFXkmdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvnnOKE/oKsqvbY02iptZ9C93v/99UAbMlLvR1mrwHY=;
 b=Q6FgAKaWtI3r1msbwp6VEfG5wCHp5a7FqjXUJKsJOzrMWFczfnkLyeIekCxlBuee9nE6xrAKXeaAGjwgVf+BVTsKfQgLqxe1nY9J0l0emFHAdpLq6Wxlq7o7SDU+lCFwQGmYyGQEWmZKAzA4egZ3Y2xftKJBlEKylo0w9V85Uso=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5381.prod.exchangelabs.com (2603:10b6:a03:11b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 23 Oct 2020 18:23:18 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 18:23:18 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH v4] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <c4b8a58e-ca55-21ec-5a0d-50ab995a1d68@arm.com>
Date:   Fri, 23 Oct 2020 11:23:15 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        patches@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BC59870-087B-40AB-ABAB-06BFD013EA22@amperemail.onmicrosoft.com>
References: <1603235425-29442-1-git-send-email-tuanphan@os.amperecomputing.com>
 <5c24da3f-4fa3-79ad-0c0d-9b4828ebf684@arm.com>
 <1EC85DEF-8E0C-42B9-9B01-DA897147B1F7@amperemail.onmicrosoft.com>
 <c4b8a58e-ca55-21ec-5a0d-50ab995a1d68@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3654.0.3.2.82)
X-Originating-IP: [73.151.56.145]
X-ClientProxiedBy: CY4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:903:18::30) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.148] (73.151.56.145) by CY4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:903:18::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 18:23:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d26314b-716f-437f-f040-08d87780b6fa
X-MS-TrafficTypeDiagnostic: BYAPR01MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB53818B722815EF0B7E078806E01A0@BYAPR01MB5381.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQVfg052ssVK8F/qWgD1KPO7fxSAWkcthAQEtyXyHsJZPzN+Pe2Nt3rksZcWfJM0aAoakVvVZEqiER826HScMMIusdYhBw76eL+5tZD7LAVylsdMbbP2xwGzTDdHeUrSoASIFo5tRfhNtF8YraCmQeFoH74jKkhqW3cLh9IXygzjH6p5pUMmcVR8xNo8QEVzNm4ryYokilWas3+b5rSo68aB4himhFyuDqK5AX67YpFmIvlkiutJhqLOpemU53BkWQ7RmWzBoBO88qR85lSXFJJmHXQCcpQ9t6TpFTqbPo/hzEYKtWy/snXKLoqKeg6AtD4eJgToh8CRgIVyJTm5ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(33656002)(186003)(478600001)(53546011)(6916009)(6486002)(956004)(42882007)(16526019)(316002)(26005)(5660300002)(4326008)(8936002)(4001150100001)(2906002)(66556008)(2616005)(54906003)(16576012)(52116002)(83380400001)(66476007)(8676002)(66946007)(83170400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: m9yxbuk6ir1eeTlS58qhaEGV4IZ4f/sy+fOfzPsF7u+5/01oaKYvg28tGVIuqFt68xh+v925K1HM3Y+UEGRAbffN81asX9oCvH5g0ugBsZwH6hZNjGe0alH4uKjpU6SdBI5d2VEdJe7I9RYdvEp+lDqGSX75sFGlsO3S7D9orQVQoMwpo+QGBmPTNLPh74j5fmS/11+qSzfCzLqqAgAztqJAR1frdFHjNwN5icavYQdlGYYNWiM+UcCeHpOvR0dT5TAVgHxTtFmfaNCHn1xJp6s/aub9alidw0idLY490vbnDTf84NLfJu4HEJudWMqPaPNx5lSGUssEh2N4J6EqiArVMzcMornhUAnRFh6fhSaBIP+0jY6sqFuVxVsUr/raaPnO/zByoP9Qpjdb+9/AdGkCqtPgXFNTHscTiLaQWGLXQ16NlxdrSwIgNefBGaTzrzCqxC66T5tcsaarlfTLxHrhZUt3sntV5Lw2/TdGlDRbodhTzdbShCP/0Xid0grLEjk9WbZPE3vTk1+qCHeL5fR+CmJ1Yu2E4YhZdfjbW/pxmB6LZQrfIPGMJZIPlS8CSnYdDSlLai6474y0OkWaYkQAlkfqrFbSQelYqwr7MZRQ6+EIRbGaaQLWKPF7mjJMk3gjhPY/662cHQckBOumvw==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d26314b-716f-437f-f040-08d87780b6fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 18:23:18.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0waB6xmvz3XbwQ2EJ7aRX4gMo5iU1D5BSTd8rrzO8kvRYDkiyuQREBjRRgW4YZ0zkU99R/XVzLX71vYRW03f3LGCT+p9D5tDFnKZFXfVNvo7h6PfcZEymJkkt749HgJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5381
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2020, at 6:43 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> On 2020-10-22 22:46, Tuan Phan wrote:
> [...]
>>>> +#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
>>>> +	((((attr)->cfg) >> lo) & GENMASK(hi - lo, 0))
>>>=20
>>> As per the buildbot report, GENMASK_ULL() would be appropriate when the=
 other side is a u64 (although either way this does look a lot like reinven=
ting FIELD_GET()...)
>> I will add (COMPILE_TEST && 64BIT) to Kconfig so it should fix the build=
bot report.
>=20
> Huh? The left-hand side of the "&" expression will always be a u64 here, =
which is unsigned long long. Regardless of whether an unsigned long on the =
right-hand side happens to be the same size, you have a semantic type misma=
tch, which is trivial to put right. I can't comprehend why introducing a fa=
ke build dependency to hide this would seem like a better idea than making =
a tiny change to make the code 100% correct and robust with zero practical =
impact :/
>=20
> Sure, you only copied this from the SPE driver; that doesn't mean it was =
ever correct, simply that the mismatch was hidden since that driver *is* ti=
ghtly coupled to one particular CPU ISA.

Got it. Actually after seeing your CMN driver which has (COMPILE_TEST && 64=
BIT), I thought the driver should be only tested under 64BIT platform. Any =
reason why CMN need 64BIT with COMPILE_TEST?

>=20
> [...]
>>>> +static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
>>>> +{
>>>> +	struct dmc620_pmu_irq *irq =3D data;
>>>> +	struct dmc620_pmu *dmc620_pmu;
>>>> +	irqreturn_t ret =3D IRQ_NONE;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	list_for_each_entry_rcu(dmc620_pmu, &irq->pmus_node, pmus_node) {
>>>> +		unsigned long status;
>>>> +		struct perf_event *event;
>>>> +		unsigned int idx;
>>>> +
>>>> +		/*
>>>> +		 * HW doesn't provide a control to atomically disable all counters.
>>>> +		 * To prevent race condition, disable all events before continuing
>>>> +		 */
>>>=20
>>> I'm still doubtful that this doesn't introduce more inaccuracy overall =
than whatever it's trying to avoid... :/
>> It think it does. By disabling all counters, you make sure overflow stat=
us not change at the same time you are clearing
>> it(by writing zero) after reading all counters.
>=20
> Urgh, *now* I get what the race is - we don't have a proper write-1-to-cl=
ear interrupt status register, so however much care we take in writing back=
 to the overflow register there's always *some* risk of wiping out a new ev=
ent when writing back, unless we ensure that no new overflows can occur *be=
fore* reading the status. What a horrible piece of hardware design... :(
>=20
> Perhaps it's worth expanding the comment a little more, since apparently =
it's not super-obvious.

I will expand the common more to explain the race condition.
>=20
> [...]
>>>> +	/*
>>>> +	 * We must NOT create groups containing mixed PMUs, although softwar=
e
>>>> +	 * events are acceptable.
>>>> +	 */
>>>> +	if (event->group_leader->pmu !=3D event->pmu &&
>>>> +			!is_software_event(event->group_leader))
>>>> +		return -EINVAL;
>>>> +
>>>> +	for_each_sibling_event(sibling, event->group_leader) {
>>>> +		if (sibling->pmu !=3D event->pmu &&
>>>> +				!is_software_event(sibling))
>>>> +			return -EINVAL;
>>>> +	}
>>>=20
>>> As before, if you can't start, stop, or read multiple counters atomical=
ly, you can't really support groups of events for this PMU either. It's imp=
ossible to measure accurate ratios with a variable amount of skew between i=
ndividual counters.
>> Can you elaborate more? The only issue I know is we can=E2=80=99t stop a=
ll counters of same PMU atomically in IRQ handler to prevent race condition=
.  But it can be fixed by manually disable each counter. Other than that, e=
very counters are working independently.
>=20
> The point of groups is to be able to count two or more events for the exa=
ct same time period, in order to measure ratios between them accurately. ->=
add, ->del, ->read, etc. are still called one at a time for each event in t=
he group, but those calls are made as part of a transaction, which for most=
 drivers is achieved by perf core calling ->pmu_disable and ->pmu_enable ar=
ound the other calls. Since this driver doesn't have enable/disable functio=
nality, the individual events will count for different lengths of time depe=
nding on what order those calls are made in (which is not necessarily const=
ant), and how long each one takes. Thus you'll end up with an indeterminate=
 amount of error between what each count represents, and the group is not r=
eally any more accurate than if the events were simply scheduled independen=
tly, which is not how it's supposed to work.
>=20
> Come to think of it, you're also not validating that groups are even sche=
dulable - try something like:
>=20
>  perf stat -e '{arm_dmc620_10008c000/clk_cycle_count/,arm_dmc620_10008c00=
0/clk_request/,arm_dmc620_10008c000/clk_upload_stall/}' sleep 5
>=20
> and observe perf core being very confused and unhappy when ->add starts f=
ailing for a group that ->event_init said was OK, since 3 events won't actu=
ally fit into the 2 available counters.
>=20
> As I said before, I think you probably would be able to make groups work =
with some careful hooking up of snapshot functionality to ->start_txn and -=
>commit_txn, but to start with it'll be an awful lot simpler to just be hon=
est and reject them.

Got it. Thanks for educating me. I will allow only one HW event then.
>=20
> [...]
>>>> +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>>> +				  "%s_%llx", DMC620_PMUNAME,
>>>> +				  (res->start) >> DMC620_PA_SHIFT);
>>>=20
>>> res->start doesn't need parentheses, however I guess it might need cast=
ing to u64 to solve the build warning (I'm not sure there's any nicer way, =
unfortunately).
>> I will remove those parentheses, we don=E2=80=99t need u64 as build warn=
ing only applies when it runs compiling test with 32bit.
>=20
> As above, deliberately hacking the build for the sake of not fixing clear=
ly dodgy code is crazy. The only correct format specifier for an expression=
 of type phys_addr_t/resource_size_t is "%pa"; if you want to use a differe=
nt format then explicitly converting the argument to a type appropriate for=
 that format (either via a simple cast or an intermediate variable) is indi=
sputably correct, regardless of whether you might happen to get away with a=
n implicit conversion sometimes.
>=20
> The whole point of maximising COMPILE_TEST coverage is to improve code qu=
ality in order to avoid this exact situation, wherein someone copies a patt=
ern from an existing driver only to discover that it's not actually as robu=
st as it should be.

Got it. Will fix it

Thanks,
Tuan.

>=20
> Robin.

