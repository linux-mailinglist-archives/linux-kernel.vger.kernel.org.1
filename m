Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E241F70E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 01:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFKXeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 19:34:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:55894 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgFKXeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:34:08 -0400
IronPort-SDR: qnpe94N+7mK8VV7j370bD7vZbeygNDMpEnDPe4QB8650a5zrhLfFMz0oGbViBx+wvM6LGNMfQu
 0elCMKD7HC2A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 16:34:07 -0700
IronPort-SDR: Ji/rKTrBrccpXvsEjBxjtp5MUqT4A4sEBWq9e9YdhONVI64t7Gk3uODYQ3az3j5WYf9wOM/+Ub
 iiFffPA0juAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="260817850"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2020 16:34:07 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 16:34:04 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 16:34:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 11 Jun 2020 16:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F66iqtkue4gIUO6GyiM6bDjvb4utiXqvMiVDLeUv4jTzB/6AJZ749QbWQjFl7r02YQ7QruGcRkZY/Uk2qQ6LvwXBBOfieRjQXMCPckmV46CbkV8IHjZDUyqAdpJzQRHrvSnvIMhS3BHbbEeWJg1O6e5qn0UCLNTDZ7aPgcmjwFTS/A0ZZ8ODjTyKvoHlVZ8hqQLEc7aJpxw8I9oat9EZDZREb+olMTMjx4p5okTtARxuZTZ458lhEHUjVIGhe0e6bPJQKjnzEJR1XbI1yaS63GKLskxTPsqLxzh0tEaIU3Wun22FD5JoowJUrMtP3ZyMacp1j9v1KMbEcYIfdaDaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM76Mw0CxzrDW25RKYqzZrYeEdccGvqlla+7wrWoDR0=;
 b=gtgZSnoOafQDvvOhKhBo72Kh30tWxT+Kgh53FY9VmGpK1KfSwIp3D0wOYjkyESmTNR/GRUuXfjWQuiaE4f6S5LUfbxjq8PgQVBv6qBQeNBNxwAjPCACovrK4qG36x5u5cgbdcHF4WCvla4EdPfOqfumgvyezwFnJxtAb5maep+cAzGg0rQz2oVCXpE2P6jVCYzJkRzFNK32sSFz2jpnVc4v8ZF2sa2clghftPtUGcw5H4wz1z4fD+oqMKp6x2Yhy3icOXEyHm0ExypU+ZkmVsmgm2QvoIh1czd88oqY4uObgNz6Lg2BZpTuNeuzbd3j7PnwYN0GZL6od/9MJ9SqRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM76Mw0CxzrDW25RKYqzZrYeEdccGvqlla+7wrWoDR0=;
 b=hcfU9eb/PX17Eozd5DdzQ1zOIAwia4d0x6XuWG4Fnb/5SAxuJW9b56tfR9ct8Akuv8SnnfPSPRTyhl9PN9+TBbrp7n/2CTjk7j6lWtIQ1HNK8hZlRcJzgBknaWIj7CFxhK0B2RiphMJvU/gziICUNSgS5U9e70YMar661Iaxv84=
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by DM5PR11MB0044.namprd11.prod.outlook.com (2603:10b6:4:64::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 23:33:59 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::b4fa:727e:34a9:b1a4]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::b4fa:727e:34a9:b1a4%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:33:59 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "authored:2/16=12%,added_lines:21/248=8%,removed_lines:5/84=6%,),Liam
        Girdwood DRIVERS )" <lgirdwood@gmail.com>,
        "commit_signer:6/16=38%,authored:6/16=38%,added_lines:123/248=50% 
        ,removed_lines:36/84=43%,Kai Vehmanen DRIVERS )" 
        <kai.vehmanen@linux.intel.com>,
        "Daniel Baluta DRIVERS )" <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "sound-open-firmware@alsa-project.orgDRIVERS" 
        <sound-open-firmware@alsa-project.orgDRIVERS>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: SOF: Intel: hda: unsolicited RIRB response
Thread-Topic: [PATCH] ASoC: SOF: Intel: hda: unsolicited RIRB response
Thread-Index: AQHWP/c4ukUWDBOd20aRgUpUZ24R5KjTeMYAgAAAtZCAADqtAIAAA8KAgAAiBYCAAAY9AIAAMAQg
Date:   Thu, 11 Jun 2020 23:33:59 +0000
Message-ID: <DM6PR11MB43168DD90582B665DF0F7D6397800@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <1591883073-17190-1-git-send-email-brent.lu@intel.com>
 <b7e0b822a9deea506acaa40e0e31cc9f488bb446.camel@linux.intel.com>
 <DM6PR11MB4316108BCF449D52E49C7E4297800@DM6PR11MB4316.namprd11.prod.outlook.com>
 <s5h5zbxeb5t.wl-tiwai@suse.de>
 <ccccab4d074878cd8fc3b3c4313025e54f78b65a.camel@linux.intel.com>
 <s5hzh99cqc0.wl-tiwai@suse.de>
 <b7e98ae0-ea42-bced-1c0f-caa73e798908@linux.intel.com>
In-Reply-To: <b7e98ae0-ea42-bced-1c0f-caa73e798908@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [36.230.210.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b10dc9e-7c41-46da-0269-08d80e5fea8e
x-ms-traffictypediagnostic: DM5PR11MB0044:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB004497E9917A7935CF47009F97800@DM5PR11MB0044.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pg7btYGaY+KbrVNVAfWcZM4+4A4XTJ4IT9UsanA0FJIoF9nuNNivpDgixXd0CCS/TYemzW/vwizWRj1QDSDLzG4uemaHQG/dh2Z+wsLWT06njNdsX8TCKyI83Bd77WtsKVP4GMdtksdgs1l5tss6A3T0lQs5hjs0kiq8eWHOgiY64J69wAeR8VtQ1lutl1pm4wJbYsRTE75RpPznJcPC1984vwv135M6N7Mp/s7j0r3pSjenseLf07QtMFzc5PTiYGRS176VPw4CwOD1J+ZAVpJyLQUz21r3ewH3K1uLNcg3d8nIjK/yBgIDV+3HX8VdASwavGPmqyWwdX4RiumBOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(8936002)(110136005)(54906003)(26005)(66556008)(55016002)(9686003)(66476007)(2906002)(4744005)(64756008)(316002)(6506007)(52536014)(66946007)(76116006)(7416002)(86362001)(7696005)(5660300002)(186003)(33656002)(8676002)(4326008)(66446008)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fI8++PfEGtRKpr4RQpndL8fStRNBQPX5EPGcU6Bw5jNWbZZDIHWcxWp99htDRBdJmB3M9EnJeT8zgY8O8MoFlPtLcgIuQTWu9I1QKoFdTt7npigF+pzIxDzFPOOHu66tPhfGkOBZSYFtGD4Qer0TaDFlqLdT85/mp46NF9lXKHTnbxvVwaYBNL5fo59vzf164Rq9fK5RoyIH3bY8UoB1bxm5EZcXmIMJLTuwdSDRm+WiJBCWIY9OLooB+eYToQXK0d6WchTLrhJF+lrmCtBaLIYRdBdUJUSvrhPUxBxGkU4d6kZtxBdJo/O6yq3hjuX6Ziz6VLgIN+cc3NK6WC/yzSgGDCQe5OeKljAZG/BjyLYCY09x+oI2CvL56toQ6iFwFsRry+YEyj0lOHIt7czGqEI7j2u3gXIOiL9n2gRpN89TkHZw8/e/tTohW01aZEquT67itD1SgaCITHA/ESjgtiilyRKJvVHzSm6L8KxPd91+Fhfl0aikqahY8CsaRWKC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b10dc9e-7c41-46da-0269-08d80e5fea8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:33:59.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpqkXw/T/iT0I1sEETr7T6xzWbVpYOVRlULsmnGtL3rxBn2ghqiAsBlhmgqA1YplYUgAoRUGh1RLhX0z/kgolA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0044
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSUlSQyB3ZSBhZGRlZCB0aGlzIGxvb3AgYmVmb3JlIG1lcmdpbmcgYWxsIGludGVycnVw
dCBoYW5kbGluZyBpbiBvbmUgdGhyZWFkLA0KPiBzb21laG93IHRoZSBNU0kgbW9kZSBuZXZlciB3
b3JrZWQgcmVsaWFibHkgd2l0aG91dCB0aGlzIGNoYW5nZSwgc28NCj4gbWF5YmUgd2UgZG9uJ3Qg
bmVlZCB0aGlzIGxvb3AgYW55IGxvbmdlci4NCj4gDQo+IEknZCByZWFsbHkgcHJlZmVyIGl0IGlm
IHdlIGRpZG4ndCB0aWUgdGhlIFJJUkIgaGFuZGluZyBjaGFuZ2UgdG8gdGhpcyBsb29wIGNoYW5n
ZSwNCj4gcmVtb3ZpbmcgdGhlIGxvb3Agc2hvdWxkIG9ubHkgYmUgZG9uZSB3aXRoICphIGxvdCBv
ZiB0ZXN0aW5nKi4NCg0KVGhlIHJlYXNvbiBJIHJlbW92ZWQgdGhlIGxvb3AgYmVjYXVzZSBJIHRo
b3VnaHQgaXQncyBmb3IgdGhlIHVuc29saWNpdGVkIHJlc3BvbnNlLA0KYXBwYXJlbnRseSBpdCdz
IG5vdC4gSSdkIGxpa2UgdG8gcG9ydCB0aGUgY29tbWl0IDZkMDExZDUwNTdmZg0KDQogICAgQUxT
QTogaGRhOiBDbGVhciBSSVJCIHN0YXR1cyBiZWZvcmUgcmVhZGluZyBXUA0KDQp0byBTT0YgZHJp
dmVyIGFuZCB1cGxvYWQgYSB2ZXJzaW9uIDIuIFRoYW5rcy4NCg0KUmVnYXJkcywNCkJyZW50DQo=
