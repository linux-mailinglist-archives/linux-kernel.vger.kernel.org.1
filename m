Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C64274F98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 05:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgIWDiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 23:38:22 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54064 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgIWDiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 23:38:21 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08N3PYiX030496;
        Tue, 22 Sep 2020 20:37:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=8SJD9nKhhiBVrhokWNfG0JlUNZ4arWiwqgs0sOPbnSU=;
 b=I5oyia1yIkIa8UpRV0zxfPZ/Ui4g146+wucIdW1lAsDcIDQapesB7IQ+pJv0i2ochCsq
 DQMTktdUAfrn6qNp6JOCndHmTPdm9dGYCXz3GYl8EXZ0cMGp9UeY9eHdZXr0gQhwk04J
 OgqlxQWCbC9FG3by5f0sWcJUq2NkU5wCf+YoJ6AHYDXoPbeAjdmIP7eKgHwOejqJFLev
 GAwI3cY2fofv9zNiZxEMm/gn9MYOKRz2fi5N3u5dtmeDWmROsVe0kUlbZJhJcgLOJODv
 ozsNy3iLCzZTDDxPXPyIEUnib+A0jIQQU+lmrXAMnqi1zmcyudD50yLeIjbpEOiENjKe mg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33ndjwvu9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 20:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOF0tL3kExW8dxHty4dh7uEb5nja2QA0vZW4yGLmMPjWVp4PqwMlMV5FSQAmRiPR2PBhVwJO/gy2ntbZ1KNXhUB/+uvRxXlRNLk1t329l7UKEVTVRHm4qS1sYD707LN+jWdLLl7A47ULzZxwZCCvgJKWv8D3lOvqM61jyJk5x8E6TjDgxeFe9z2jCOzO4KoHXLdQWHb6GtqNdnDJy8fbeEECoizsaGpUixaFkd7R1Kj4BZWPH0NyvYoobP8NCIyQo8/3lr8zbNsbxTxPvCAYRA3jYEW99j+EKEhKebaUxM+u7dGUxWLy7FASfRSeiHFcCISbT2mLvmsWuXL61stzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SJD9nKhhiBVrhokWNfG0JlUNZ4arWiwqgs0sOPbnSU=;
 b=TUres7vvGShIoAeKAEN0L+/sbCnP7LOrS/ZMgBs5pwP4T6OCG15qOUsDexwQpPgTIt66pybRQ1mFUBmVAwSq7iJUt074GjkWSAk4+9KYEkCK+ZfI/HNFws0gGJMpUk3hQxT0mIyzmf0CJ33K6GIXOnUmvl+NPd0QHWXtVVLOIPdCJVMjQ9kN6pnYp+dG8dXA+l20zPiM2HVLGpWC6oA0iYia+cda4KPk3G3YV+fz5hBWqXHgy+/6HuCQ58Mh3NHMhfGwe5/x0JAqpEQQTE3/0pD9Wf859faBaUljME2rb7f4eLTzdEixcHRAMT76WwYG8MTaaNV+jmUx0dAyB1qXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SJD9nKhhiBVrhokWNfG0JlUNZ4arWiwqgs0sOPbnSU=;
 b=c6L/DywXb5Sng37KfardqCTJD0SYPD/hV32YOX1dqN7Nym4VX2mDgisnImAn5VdvJ/0kL4FRwtfc6Ss9M2ILDNoZqINsYAaCSNZjBAMciZbNFVT2oSJphiuCkoIOnzOP92XCiEhC3UcvY8yf7e5jDxdvAgUunTk0ClC83u8uW94=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB6667.namprd07.prod.outlook.com (2603:10b6:5:1c1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Wed, 23 Sep 2020 03:37:43 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3391.011; Wed, 23 Sep 2020
 03:37:42 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWS3YSDa4tJNrkMUOR89XcmNbpYKjqdbIAgAABeQCABIBZgIAADfQAgIYgtQCAAO0xAIAABQBA
Date:   Wed, 23 Sep 2020 03:37:42 +0000
Message-ID: <DM6PR07MB5529164EFCDF36CE75E8AF3DDD380@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <878sga5nfr.fsf@kernel.org>
 <BL0PR07MB5522A8796EE7BFB5062A8E76DD930@BL0PR07MB5522.namprd07.prod.outlook.com>
 <20200629034213.GB30684@b29397-desktop> <20200629043146.GA323164@kroah.com>
 <DM6PR07MB5529B75D3CF135D540749C1DDD3B0@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20200923025540.GA31183@b29397-desktop>
In-Reply-To: <20200923025540.GA31183@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: {51BD6E37-66BD-4186-8AFE-835F952BA4E6};
 {F0B656D1-F768-43A1-A424-45742A6E25CF}
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMjA5MTYxODEtZmQ0ZS0xMWVhLTg3NmItMWM0ZDcw?=
 =?us-ascii?Q?MWRmYmE0XGFtZS10ZXN0XDIwOTE2MTgyLWZkNGUtMTFlYS04NzZiLTFjNGQ3?=
 =?us-ascii?Q?MDFkZmJhNGJvZHkudHh0IiBzej0iNjA2OSIgdD0iMTMyNDUzMDU4NTk0OTkz?=
 =?us-ascii?Q?NTczIiBoPSJTdnJsZkZtT0E3NjAzNStHeEQ3YllPRmJzRWM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFPNEpBQUJt?=
 =?us-ascii?Q?SFBrbVU1SFdBWXNJQTE1Ry9lb1JoMm9jVFhBZCs2UU9BQUFBQUFBQUFOb0FB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFGQWtBQU5vQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFEQUFBQXQzMG1Gd0FBQUFBQUFBQUFBQUFBQUo0QUFBQmpBR0VBWkFC?=
 =?us-ascii?Q?bEFHNEFZd0JsQUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVlRQmtBR1VBYmdCakFHVUFYd0Jr?=
 =?us-ascii?Q?QUdVQWN3QnBBR2NBYmdCZkFITUFlUUJ6QUhRQVpRQnRBSE1BQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0JoQUdRQVpRQnVBR01BWlFCZkFIQUFjZ0J2QUdRQWRRQmpB?=
 =?us-ascii?Q?SFFBY3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFC?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFHOEFk?=
 =?us-ascii?Q?UUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZUUJ6QUcwQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3?=
 =?us-ascii?Q?QmtBR1VBWHdCakFHOEFZZ0J2QUd3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY0FC?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4?=
 =?us-ascii?Q?QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVl3QnpBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01B?=
 =?us-ascii?Q?YndCa0FHVUFYd0JsQUhVQWNBQm9BRzhBY2dCcEFHRUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHWUFi?=
 =?us-ascii?Q?d0J5QUhRQWNnQmhBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?RzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJ3QjFBSElBWXdCbEFH?=
 =?us-ascii?Q?TUFid0JrQUdVQVh3QndBSGtBZEFCb0FHOEFiZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhJ?=
 =?us-ascii?Q?QWRRQmlBSGtBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjd0IwQUd3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BYndCMUFISUFZd0Js?=
 =?us-ascii?Q?QUdNQWJ3QmtBR1VBWHdCMkFHSUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQURhQUFBQUFBQUFBREFBQUFBQ0FBQUFBQUFBQUN6QUFEWXZu?=
 =?us-ascii?Q?eEJMbjN5NWU3NTRhWmtCQUFBQU4wOUREVVJ4ZDAyMmVGVkRaRHZVNVRBQUFB?=
 =?us-ascii?Q?QUNBQUFBQVFBQUFMTGNGekEwTnUxTGx1T3VjTGFYdUVvQUFBQUF3Mkc1bGZi?=
 =?us-ascii?Q?MjdFeVZDMzNrcCs1ciszSUFBQUFDQUFBQUtnQUFBQUFBQUFCakFHUUFiZ0Fn?=
 =?us-ascii?Q?QUhNQWJ3QjFBSElBWXdCbEFDQUFZd0J2QUdRQVpRQnpBQUFBUUFBQUFBRUFB?=
 =?us-ascii?Q?QUJqQUdRQWJnQmZBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFH?=
 =?us-ascii?Q?OEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUFBQUE9PSIvPjwvbWV0YT4?=
 =?us-ascii?Q?=3D?=
x-dg-paste: 
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b67dce4b-75da-438d-6d68-08d85f72077a
x-ms-traffictypediagnostic: DM6PR07MB6667:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB66673E1095120FA63A2AB1A0DD380@DM6PR07MB6667.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dt4n1gdj3c9t3mJZ8cwNToKjNYe8N6gz3kEzs84w+BRZI0d5rZt6xVnPXSVPTdJKAwGWl9RMYi7tSimLh4kWnDP09AK3gqPHJ4fdFeLF6CYpyXxQWOXG5vHXRzxFQYnYukeM/T3HWJ65kD09YwXGuhPHzXG87MjdQdcTeLBj7TM9a0wPAPm0F4yV6NA7hyMf1DzxGmCkc2N1nGW4IB7qom8FFu+r286VssISTU2EWe9+EhLvoDL0pRyyub32nBjdtprxtx/R6XftvB0yXBeJj08y2W7ESHHt4P/fn4iGi4J0zh85sZkdUIlHrFoYKfixlHWunWVWVCfcL3hl65HBS/bb/6TvLvRChi+ujJs2ZOHLg/iHV8dQZhBqrlOZG9drg5dEw2TDO/UWq34JuG8PvuQdwCppfPSYgGC/3W6UL0o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(36092001)(2906002)(8676002)(54906003)(7696005)(33656002)(6506007)(53546011)(83380400001)(186003)(478600001)(4326008)(26005)(7416002)(86362001)(8936002)(107886003)(9686003)(66556008)(76116006)(66476007)(66946007)(64756008)(66446008)(52536014)(71200400001)(5660300002)(55016002)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cZ8rdcHauT5E1KNiMh+HcWvfIbNylZ6iHfR0VU3/vG0W/0ySR6VCmR+rgbm7toPTDa689fyyQUWd2lBzVa38HNMRCSFj/9kYBngsO+T50FU5ktPvJstL/E1wtG4LbLPlbSHvnVvCtiYSyhQHfw0H+M2MruCSA6/eWr6jFaO9FL2fRer18/6NSvLPPTcMXMhUvA+2sfjUO0MkjGBuoQmrD7xzDoV++oulVtY6kEuNXn0l3xeM31/heexmUh1s2sue6kB8p6vBHcqxnS5hrA6iujH6rHDyEnR4pyWuw6MXX0KrQ/Eftx/Nds7ZvveX8aCTBZOvmnPfsyNExGq7ZEKOCqTUp3/pEmACFBnNxHajOoT9EMOgWoyKbt6Df1cZ5vOA34RS+PWaQQuM5Pm9x3z57K6+cYsTzo60gGxHknEC6HhDFjn38y2gWjL0MB7HDtN+5OE5+S+2dipYrET5s5U87LLC0K+t1Xy0WmsfeBO5Gm2ghwu7vvuwLLgmNeU4DrdWxQ4LqZzXAp2t+jh6cr8KwPoNNMeCLi52li/zYBZzOyGMzl5OLug9V0ppMciP5BziatYcyPY2WmzrE/XPI4B8mwkZCjoPxZiS9eFJB9Zh3CqXwMpPlW2xUP0tG9iVtmfNDuo6BdoU9ORwUHMqBMpuIQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67dce4b-75da-438d-6d68-08d85f72077a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 03:37:42.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFb8RG9WbSYf7vVQjHtOy8z9EVjEXNyQh+yYXsPLA5SwXdjkT9qbYD3BPPcw9b2mQbpkGD9QL+zEhb6EmxzFHw+H2twD+b/nQWDcxbHS6l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6667
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_02:2020-09-21,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxlogscore=883 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On 20-09-22 13:06:26, Pawel Laszczak wrote:
>> Hi,
>>
>> >
>> >On Mon, Jun 29, 2020 at 03:41:49AM +0000, Peter Chen wrote:
>> >> On 20-06-26 07:19:56, Pawel Laszczak wrote:
>> >> > Hi Felipe,
>> >> >
>> >> > >
>> >> > >Hi,
>> >> > >
>> >> > >Pawel Laszczak <pawell@cadence.com> writes:
>> >> > >> This patch introduce new Cadence USBSS DRD driver to linux kerne=
l.
>> >> > >>
>> >> > >> The Cadence USBSS DRD Controller is a highly configurable IP Cor=
e which
>> >> > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only a=
nd
>> >> > >> Host Only (XHCI)configurations.
>> >> > >>
>> >> > >> The current driver has been validated with FPGA burned. We have =
support
>> >> > >> for PCIe bus, which is used on FPGA prototyping.
>> >> > >>
>> >> > >> The host side of USBSS-DRD controller is compliance with XHCI
>> >> > >> specification, so it works with standard XHCI Linux driver.
>> >> > >>
>> >> > >> The host side of USBSS DRD controller is compliant with XHCI.
>> >> > >> The architecture for device side is almost the same as for host =
side,
>> >> > >> and most of the XHCI specification can be used to understand how
>> >> > >> this controller operates.
>> >> > >>
>> >> > >> This controller and driver support Full Speed, Hight Speed, Supp=
er Speed
>> >> > >> and Supper Speed Plus USB protocol.
>> >> > >>
>> >> > >> The prefix cdnsp used in driver has chosen by analogy to cdn3 dr=
iver.
>> >> > >> The last letter of this acronym means PLUS. The formal name of c=
ontroller
>> >> > >> is USBSSP but it's to generic so I've decided to use CDNSP.
>> >> > >>
>> >> > >> The patch 1: adds DT binding.
>> >> > >> The patch 2: adds PCI to platform wrapper used on Cadnece testin=
g
>> >> > >>              platform. It is FPGA based on platform.
>> >> > >> The patches 3-5: add the main part of driver and has been intent=
ionally
>> >> > >>              split into 3 part. In my opinion such division shou=
ld not
>> >> > >>              affect understanding and reviewing the driver, and =
cause that
>> >> > >>              main patch (4/5) is little smaller. Patch 3 introdu=
ces main
>> >> > >>              header file for driver, 4 is the main part that imp=
lements all
>> >> > >>              functionality of driver and 5 introduces tracepoint=
s.
>> >> > >
>> >> > >I'm more interested in how is this different from CDNS3. Aren't th=
ey SW compatible?
>> >> >
>> >> > In general, the controller can be split into 2 part- DRD part and t=
he rest UDC.
>> >> >
>> >> > The second part UDC which consist gadget.c, ring.c and mem.c file i=
s completely different.
>> >> >
>> >> > The DRD part contains drd.c and core.c.
>> >> > cdnsp drd.c is similar to cdns3 drd.c but it's little different. CD=
NSP has similar, but has different register space.
>> >> > Some register was moved, some was removed and some was added.
>> >> >
>> >> > core.c is very similar and eventually could be common for both driv=
ers.  I thought about this but
>> >> > I wanted to avoid interfering with cdns3 driver at this point CDNSP=
 is still under testing and
>> >> > CDNS3 is used by some products on the market.
>> >>
>> >> Pawel, I suggest adding CDNSP at driver/staging first since it is sti=
ll
>> >> under testing. When you are thinking the driver (as well as hardware)=
 are
>> >> mature, you could try to add gadget part (eg, gadget-v2) and make
>> >> necessary changes for core.c.
>> >
>> >I only take code for drivers/staging/ that for some reason is not
>> >meeting the normal coding style/rules/whatever.  For stuff that is an
>> >obvious duplicate of existing code like this, and needs to be
>> >rearchitected.  It is much more work to try to convert code once it is
>> >in the tree than to just do it out of the tree on your own and resubmit
>> >it, as you don't have to follow the in-kernel rules of "one patch does
>> >one thing" that you would if it was in staging.
>> >
>> >So don't think that staging is the right place for this, just spend a
>> >few weeks to get it right and then resubmit it.
>> >
>>
>> I had idea to reuse indirect the core.c and drd.c in cdnsp driver. Of co=
urse, I've made
>> the necessary changes to make possible reuse this code.
>> My approach was to add this file in Makefile in cdnsp but this concept f=
ailed.
>> It even worked until I started testing cdns3 and cdnsp as build in kerne=
l :)
>>
>> With this approach I have issue with " multiple definition of .. "
>>
>> How should it look like such reusable code ?
>>
>> After my experience with above concept I think that only way is to move =
common code
>> to separate module,  similar as it is in drivers/usb/common directory or=
 libcomposite.ko module.
>>
>
>Could you use compatible string or IP revision number to dynamic judge
>which part of code you should use? That is to say there is only one
>Cadence 3 USB driver folder -- cdns3, you only add one gadget file for
>cdnsp revision?
>

I'm able to recognize in dynamic way which part of code is used, and it wor=
ks correct.
The problem is when I want to build both driver in kernel at the same time.=
=20

I have two separate directory cdnsp and cdns3 and both has separate Makefil=
e.

In cdns3 Makefile there is=20
...
cdns3-y					:=3D cdns3-plat.o core.o drd.o
..

In cdnsp Makefile there is:=20
..
cdnsp-pci-y				:=3D cdnsp-pci.o ../cdns3/core.o \
					   ../cdns3/drd.o
...

During compiling kernel, the compilator compile twice core.c and drd.c.=20
At this moment all is ok, but during preparing the kernel image the=20
compiler complains that he sees duplicated all non-static function from=20
core.c drd.c.  It's looks like he tries to add twice the same function.=20

Moving common code (most of core core.c and drd.c) to separate module,
this non static reusable function will be compiled in kernel only once and =
both
driver can reuse it.  The only inconvenience is that, we need load one addi=
tional=20
module to use driver.
--
Thanks =20
Pawel Laszczak
